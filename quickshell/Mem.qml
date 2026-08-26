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

    property int memUsage: 0
    property var memUsed: 0
    property var memTotal: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    readonly property string icon: String.fromCodePoint(0xEFC5)

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total)
                memUsed = Math.round(10 * used / 1000000) / 10
                memTotal = Math.round(10 * total / 1000000) / 10
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000        // Every 2 seconds
        running: true         // Start immediately
        repeat: true          // Keep going forever
        onTriggered: memProc.running = true
    }

    Text {
        text: root.icon

        color: memUsage >= 75 ? root.colRed
            :  memUsage >= 50 ? root.colYellow
            :  memUsage >= 25 ? root.colCyan
            :  root.colGreen

        font {
            family: root.fontFamily
            pixelSize: root.pixelSize + 2
            bold: true
        }
    }

    Text {
        text: memUsed + "GB/" + memTotal + "GB"

        color: memUsage >= 75 ? root.colRed
            :  memUsage >= 50 ? root.colYellow
            :  memUsage >= 25 ? root.colCyan
            :  root.colGreen

        font {
            family: "SF Pro Display"
            pixelSize: root.pixelSize
            weight: 500
        }
    }

    Text {
        text: memUsage + "%"

        color: memUsage >= 75 ? root.colRed
            :  memUsage >= 50 ? root.colYellow
            :  memUsage >= 25 ? root.colCyan
            :  root.colGreen

        font {
            family: "SF Pro Display"
            pixelSize: root.pixelSize
            weight: 500
        }
    }
}

