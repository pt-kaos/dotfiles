import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts		//For RowLayout

RowLayout {
    id: root
    spacing: 7

    property var sink: Pipewire.defaultAudioSink
    readonly property bool ready: sink && Pipewire.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) : 0
    readonly property string icon: {
        if (!ready) return String.fromCodePoint(0xF0581)
        if (muted) return String.fromCodePoint(0xF05)
        if (vol === 0) return String.fromCodePoint(0xF0581)
        if (vol < 34) return String.fromCodePoint(0xF057F)
        if (vol < 67) return String.fromCodePoint(0xF0580)
        
        return String.fromCodePoint(0xF057E)
    }

    Text {
        text: root.icon
        color: "#f5cd5b"

        font {
            family: "JetBrainsMono Nerd Font Propo"
            pixelSize: 13
        }
        
    }
    Text {
        text: {
            if (!root.ready) return "-"
            if (root.muted) return "Muted"

            return root.vol + "%"
        }

        color: root.muted ? "#c4b09a" : "#f5cd5b"

        font {
            family: "SF Pro Display"
            //pixelSize: 13
            weight: 500
        }
    }
    PwObjectTracker {
        objects: [root.sink]
    }
}

