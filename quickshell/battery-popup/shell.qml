// Battery popup (Omarchy-style). Standalone Quickshell config.
//   run:    quickshell -p <this dir>            (own instance, never the live bar)
//   toggle: quickshell -p <this dir> ipc call battery toggle      (also: open / close)
// Scratch switches (env): BP_OPEN=1 start open, BP_PROFILES_DEMO=1 pretend a profile backend exists.
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

ShellRoot {
    id: root

    // ---- tokens (mirror theme/palette.sh; QML wants #AARRGGBB) -------------
    readonly property color cBg:        "#f512140f"   // BG, slightly translucent
    readonly property color cBgAlt:     "#1a1c17"     // BG_ALT
    readonly property color cFg:        "#d3d7d1"     // FG
    readonly property color cDim:       "#8b978a"     // FG_DIM
    readonly property color cAccent:    "#8fae6f"     // ACCENT
    readonly property color cAccentDim: "#607850"     // ACCENT_DIM
    readonly property color cWarn:      "#e0a458"     // WARNING
    readonly property color cCrit:      "#e05c5c"     // CRITICAL
    readonly property string font: "JetBrainsMono Nerd Font"
    readonly property int fsTitle: 15
    readonly property int fsPct: 30
    readonly property int fsBody: 12
    readonly property int fsLabel: 10
    readonly property int pad: 16
    readonly property int gap: 8
    readonly property int radius: 6
    readonly property int cardW: 360
    readonly property int barH: 26          // waybar reserved top
    readonly property int edgeGap: 4        // gap below the bar
    readonly property int rightInset: 8     // distance from screen right edge
    readonly property int fadeMs: 120

    // ---- data ---------------------------------------------------------------
    readonly property var dev: UPower.displayDevice
    readonly property bool present: dev && dev.isPresent
    readonly property real pct: present ? Math.round(dev.percentage * (dev.percentage <= 1 ? 100 : 1)) : 0
    readonly property int st: present ? dev.state : 0
    readonly property bool charging: st === UPowerDeviceState.Charging
    readonly property bool discharging: st === UPowerDeviceState.Discharging
    readonly property bool full: st === UPowerDeviceState.FullyCharged
    property string cycles: "—"
    property real designWh: 0
    property int healthPct: 0
    property string limit: ""      // "" = kernel exposes no charge limit
    readonly property bool profilesDemo: Quickshell.env("BP_PROFILES_DEMO") === "1"
    readonly property bool profilesBackend: profilesDemo   // real detection comes at install time

    function fmtTime(s) {
        if (!s || s <= 0) return "—";
        var h = Math.floor(s / 3600), m = Math.floor((s % 3600) / 60);
        return h > 0 ? h + "h " + m + "m" : m + "m";
    }
    readonly property string stateText: !present ? "NO BATTERY" : full ? "FULLY CHARGED" : charging ? "CHARGING" : discharging ? "DISCHARGING" : "IDLE"
    readonly property color levelColor: (discharging && pct <= 15) ? cCrit : (discharging && pct <= 30) ? cWarn : cAccent
    readonly property string glyph: charging ? "" : pct > 87 ? "" : pct > 62 ? "" : pct > 37 ? "" : pct > 12 ? "" : ""

    FileView { id: fCycles; path: "/sys/class/power_supply/BAT0/cycle_count"; onLoaded: root.cycles = text().trim() }
    FileView { id: fNow;    path: "/sys/class/power_supply/BAT0/charge_full"; onLoaded: root.recalc() }
    FileView { id: fFull;   path: "/sys/class/power_supply/BAT0/charge_full_design"; onLoaded: root.recalc() }
    FileView { id: fVolt;   path: "/sys/class/power_supply/BAT0/voltage_min_design"; onLoaded: root.recalc() }
    FileView { id: fLimit;  path: "/sys/class/power_supply/BAT0/charge_control_end_threshold"; onLoaded: root.limit = text().trim() + "%" }
    function recalc() {
        try { healthPct = Math.round(parseInt(fNow.text()) * 100 / parseInt(fFull.text())); } catch (e) { healthPct = 0; }
        try { designWh = parseInt(fFull.text()) * parseInt(fVolt.text()) / 1e12; } catch (e) { designWh = 0; }
    }
    function refresh() { fCycles.reload(); fNow.reload(); fFull.reload(); fVolt.reload(); fLimit.reload(); }

    // ---- window -------------------------------------------------------------
    property bool open: Quickshell.env("BP_OPEN") === "1"
    onOpenChanged: if (open) refresh()
    Component.onCompleted: refresh()

    IpcHandler {
        target: "battery"
        function toggle(): void { root.open = !root.open }
        function open(): void { root.open = true }
        function close(): void { root.open = false }
    }

    PanelWindow {
        id: win
        visible: root.open || card.opacity > 0.01
        color: "transparent"
        anchors { top: true; left: true; right: true; bottom: true }
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "battery-popup"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: root.open ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

        // outside click closes
        MouseArea { anchors.fill: parent; onClicked: root.open = false }

        FocusScope {
            anchors.fill: parent
            focus: true
            Keys.onEscapePressed: root.open = false

            Rectangle {
                id: card
                width: root.cardW
                height: col.implicitHeight + root.pad * 2
                x: parent.width - width - root.rightInset
                y: root.barH + root.edgeGap + (root.open ? 0 : -6)
                color: root.cBg
                radius: root.radius
                border.width: 1
                border.color: root.cAccent
                opacity: root.open ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: root.fadeMs; easing.type: Easing.OutCubic } }
                Behavior on y { NumberAnimation { duration: root.fadeMs; easing.type: Easing.OutCubic } }
                MouseArea { anchors.fill: parent }   // swallow clicks inside the card

                Column {
                    id: col
                    x: root.pad; y: root.pad
                    width: parent.width - root.pad * 2
                    spacing: 14

                    // header
                    Item {
                        width: parent.width; height: 44
                        Text { id: ic; text: root.glyph; color: root.levelColor; font.family: root.font; font.pixelSize: 24
                               anchors.verticalCenter: parent.verticalCenter }
                        Column {
                            anchors { left: ic.right; leftMargin: 14; verticalCenter: parent.verticalCenter }
                            spacing: 2
                            Text { text: "Battery"; color: root.cFg; font.family: root.font; font.pixelSize: root.fsTitle; font.bold: true }
                            Text { text: root.stateText; color: root.cDim; font.family: root.font; font.pixelSize: root.fsLabel; font.letterSpacing: 1.5 }
                        }
                        Text { text: root.pct + "%"; color: root.cFg; font.family: root.font; font.pixelSize: root.fsPct
                               anchors { right: parent.right; verticalCenter: parent.verticalCenter } }
                    }

                    // bar
                    Rectangle {
                        width: parent.width; height: 8; radius: 4; color: root.cBgAlt
                        border.width: 1; border.color: root.cAccentDim
                        Rectangle { width: Math.max(8, parent.width * root.pct / 100); height: parent.height; radius: 4; color: root.levelColor
                                    Behavior on width { NumberAnimation { duration: root.fadeMs } } }
                    }

                    // stats grid
                    Grid {
                        columns: 2; columnSpacing: 20; rowSpacing: 8
                        width: parent.width
                        Repeater {
                            model: [
                                { k: "Battery size",   v: root.designWh > 0 ? root.designWh.toFixed(0) + " Wh" : "—" },
                                { k: root.discharging ? "Time left" : root.full ? "Time to full" : "Time to full",
                                  v: root.full ? "—" : root.fmtTime(root.discharging ? root.dev.timeToEmpty : root.dev.timeToFull) },
                                { k: "Charge cycles",  v: root.cycles },
                                { k: root.discharging ? "Discharging" : root.charging ? "Charging" : "Power draw",
                                  v: root.present ? Math.abs(root.dev.changeRate).toFixed(1) + " W" : "—" },
                                { k: "Health",         v: root.healthPct > 0 ? root.healthPct + "%" : "—" },
                                { k: "Charge limit",   v: root.limit !== "" ? root.limit : "n/a" }
                            ]
                            Item {
                                required property var modelData
                                width: (col.width - 20) / 2; height: 18
                                Text { text: modelData.k; color: root.cDim; font.family: root.font; font.pixelSize: root.fsBody; anchors.left: parent.left }
                                Text { text: modelData.v; color: root.cFg; font.family: root.font; font.pixelSize: root.fsBody; anchors.right: parent.right }
                            }
                        }
                    }

                    Rectangle { width: parent.width; height: 1; color: root.cAccentDim; opacity: 0.5 }

                    // power profile
                    Column {
                        width: parent.width; spacing: 10
                        Text { text: "POWER PROFILE"; color: root.cDim; font.family: root.font; font.pixelSize: root.fsLabel; font.letterSpacing: 1.5 }
                        Row {
                            id: prow
                            width: parent.width; spacing: 6
                            property string active: "performance"   // demo; real value comes from the backend
                            Repeater {
                                model: [
                                    { id: "power-saver", label: "Power-saver", icon: "" },
                                    { id: "balanced",    label: "Balanced",    icon: "" },
                                    { id: "performance", label: "Performance", icon: "" }
                                ]
                                Rectangle {
                                    required property var modelData
                                    readonly property bool sel: root.profilesBackend && prow.active === modelData.id
                                    width: (prow.width - 12) / 3; height: 34; radius: root.radius - 2
                                    color: sel ? root.cAccentDim : root.cBgAlt
                                    border.width: 1; border.color: sel ? root.cAccent : root.cAccentDim
                                    opacity: root.profilesBackend ? 1 : 0.45
                                    Row {
                                        anchors.centerIn: parent; spacing: 6
                                        Text { text: modelData.icon; color: root.cFg; font.family: root.font; font.pixelSize: 12 }
                                        Text { text: modelData.label; color: root.cFg; font.family: root.font; font.pixelSize: root.fsLabel + 1; font.bold: sel }
                                    }
                                    MouseArea { anchors.fill: parent; enabled: root.profilesBackend; onClicked: prow.active = modelData.id }
                                }
                            }
                        }
                        Text { visible: !root.profilesBackend; width: parent.width; wrapMode: Text.WordWrap
                               text: "No power-profile backend installed (TLP only). Switching disabled."
                               color: root.cDim; font.family: root.font; font.pixelSize: root.fsLabel }
                    }
                }
            }
        }
    }
}
