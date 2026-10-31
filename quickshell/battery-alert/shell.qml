// Battery alert overlay. Standalone Quickshell config: quickshell -c battery-alert
// Trigger:  battery-alert-ui <warning|critical|burst> "Title" "Body" [ms]
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

ShellRoot {
    id: root

    // ---- tokens (edit here) ------------------------------------------------
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int titleSize: 48
    readonly property int bodySize: 32
    readonly property int buttonSize: 32
    readonly property int holdMs: 5000      // default time on screen
    readonly property int slideInMs: 380
    readonly property int slideOutMs: 420
    readonly property int cardW: 1000
    readonly property int cardH: 330
    readonly property int radius: 24
    // level -> [background, text, border/accent]
    readonly property var styles: ({
        warning:  { bg: "#ffb000", fg: "#1a1000", edge: "#1a1000", mark: "!" },
        critical: { bg: "#d00f1e", fg: "#ffffff", edge: "#ffffff", mark: "!" },
        burst:    { bg: "#8f0010", fg: "#ffffff", edge: "#ffffff", mark: "!!" }
    })

    // ---- state -------------------------------------------------------------
    property string level: "warning"
    property string title: ""
    property string body: ""
    property int curHold: holdMs
    property var st: styles[level] || styles.warning
    property bool active: false             // window visible
    property string wantMonitor: ""

    function show(lvl, t, b, ms) {
        level = styles[lvl] ? lvl : "warning";
        title = t; body = b;
        curHold = ms > 0 ? ms : holdMs;
        const fm = Hyprland.focusedMonitor;
        wantMonitor = fm ? fm.name : "";
        const first = !active;
        active = true;
        if (outAnim.running) outAnim.stop();
        if (first) slide = 0;
        if (Math.abs(slide - 1) > 0.001) { inAnim.from = slide; inAnim.restart(); }
        hold.interval = curHold; hold.restart();
        timeBar.restart();
        pulse.restart();
    }
    function hide() { hold.stop(); timeBar.stop(); if (active && !outAnim.running) { inAnim.stop(); outAnim.restart(); } }
    // slide: 0 = above screen, 1 = centred, 2 = below screen (y is bound, so it follows window size)
    property real slide: 0

    IpcHandler {
        target: "alert"
        function popup(level: string, title: string, body: string, ms: int): void { root.show(level, title, body, ms); }
        function dismiss(): void { root.hide(); }
    }

    Timer { id: hold; onTriggered: root.hide() }

    PanelWindow {
        id: win
        visible: root.active
        screen: {
            for (const s of Quickshell.screens) if (s.name === root.wantMonitor) return s;
            return Quickshell.screens[0];
        }
        anchors { top: true; bottom: true; left: true; right: true }
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
        WlrLayershell.namespace: "battery-alert"
        mask: Region { item: card }

        Rectangle {
            id: card
            width: root.cardW; height: root.cardH
            x: (win.width - width) / 2
            y: {
                const cy = (win.height - height) / 2;
                return root.slide <= 1 ? -height + root.slide * (cy + height) : cy + (root.slide - 1) * (win.height - cy);
            }
            radius: root.radius
            color: root.st.bg
            border.color: root.st.edge
            border.width: 6
            clip: true

            NumberAnimation { id: inAnim; target: root; property: "slide"; to: 1; duration: root.slideInMs; easing.type: Easing.OutBack; easing.overshoot: 0.8 }
            SequentialAnimation {
                id: outAnim
                NumberAnimation { target: root; property: "slide"; to: 2; duration: root.slideOutMs; easing.type: Easing.InCubic }
                ScriptAction { script: root.active = false }
            }
            // gentle pulse on every (re)show so updates are noticed
            SequentialAnimation {
                id: pulse
                NumberAnimation { target: card; property: "scale"; to: 1.03; duration: 90 }
                NumberAnimation { target: card; property: "scale"; to: 1.0; duration: 140 }
            }

            Rectangle {
                id: mark
                width: 120; height: 120; radius: 60
                anchors { left: parent.left; leftMargin: 40; top: parent.top; topMargin: 50 }
                color: "transparent"
                border.color: root.st.fg; border.width: 8
                Text {
                    anchors.centerIn: parent
                    text: root.st.mark
                    color: root.st.fg
                    font { family: root.fontFamily; pixelSize: 72; bold: true }
                }
            }
            Text {
                id: titleText
                anchors { left: mark.right; leftMargin: 36; right: parent.right; rightMargin: 40; top: parent.top; topMargin: 44 }
                text: root.title
                color: root.st.fg
                elide: Text.ElideRight
                font { family: root.fontFamily; pixelSize: root.titleSize; bold: true }
            }
            Text {
                anchors { left: titleText.left; right: parent.right; rightMargin: 40; top: titleText.bottom; topMargin: 12 }
                text: root.body
                color: root.st.fg
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                elide: Text.ElideRight
                font { family: root.fontFamily; pixelSize: root.bodySize }
            }
            Rectangle {
                id: btn
                width: 260; height: 72; radius: 16
                anchors { right: parent.right; rightMargin: 40; bottom: parent.bottom; bottomMargin: 36 }
                color: ma.containsMouse ? root.st.fg : "transparent"
                border.color: root.st.fg; border.width: 4
                Text {
                    anchors.centerIn: parent
                    text: "Got it!"
                    color: ma.containsMouse ? root.st.bg : root.st.fg
                    font { family: root.fontFamily; pixelSize: root.buttonSize; bold: true }
                }
                MouseArea { id: ma; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.hide() }
            }
            // time-left bar (state not by colour alone)
            Rectangle {
                id: bar
                height: 10
                anchors { left: parent.left; bottom: parent.bottom }
                color: root.st.fg
                width: parent.width
                NumberAnimation { id: timeBarAnim; target: bar; property: "width"; to: 0; duration: root.curHold }
            }
        }
    }
    QtObject {
        id: timeBar
        function restart() { bar.width = card.width; timeBarAnim.duration = root.curHold; timeBarAnim.restart(); }
        function stop() { timeBarAnim.stop(); }
    }
}
