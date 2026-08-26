import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts		//For RowLayout

RowLayout {
    id: root
    spacing: 7

	property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
	property color colRed: "#e89aa8"
	property color colGreen: "#b2cca0"
	
	property string fontFamily: "JetBrainsMono Nerd Font Propo"
    property var pixelSize: 13

    property int cpuUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    readonly property string icon: String.fromCodePoint(0xF0EE0)

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000        // Every 2 seconds
        running: true         // Start immediately
        repeat: true          // Keep going forever
        onTriggered: cpuProc.running = true
    }

    Text {
        text: root.icon

        color: cpuUsage >= 75 ? root.colRed
            :  cpuUsage >= 50 ? root.colYellow
            :  cpuUsage >= 25 ? root.colCyan
            :  root.colGreen

        font {
            family: root.fontFamily
            pixelSize: root.pixelSize + 2
            bold: true
        }
    }

    Text {
        text: cpuUsage + "%"

        color: cpuUsage >= 75 ? root.colRed
            :  cpuUsage >= 50 ? root.colYellow
            :  cpuUsage >= 25 ? root.colCyan
            :  root.colGreen

        font {
            family: "SF Pro Display"
            pixelSize: root.pixelSize
            weight: 500
        }
    }
}
