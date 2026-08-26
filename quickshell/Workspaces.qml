import Quickshell
import Quickshell.Hyprland	//Hyprland IPC access
import QtQuick
import QtQuick.Layouts		//For RowLayout

RowLayout {
    spacing: 6

    Repeater {
        model: 9

        Rectangle {
            id: wsButton
            property color colInactive:   "#242b2a"
            property color colActive: "#673030"
            property color colButInactive: "#545b6a"
            property color colButActive: "#cbcba4"
            required property int index

			property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
			property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: label.implicitWidth + 14
            implicitHeight: 22
            radius: 10

			//color: isActive ? "#1d3631" : (ws ? "#0f211f" : "transparent")
			color: isActive ? colActive : (ws ? colInactive : "transparent")

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: wsButton.index + 1
                //color: wsButton.isActive ? "#3dd1b0" : (wsButton.ws ? "#f5e2c5" : "#5a4d3e")
                color: wsButton.isActive ? colButActive : (wsButton.ws ? colButInactive : "#5a4d3e")

                font {
                    //family: "SF Mono"
                    pixelSize: 12
                    weight: 500
                }
            }

			MouseArea {
				anchors.fill: parent
				//onClicked: Hyprland.dispatch("hl.dispatch(hl.dsp.workspace.workspace(" + (index + 1) + "))")
				onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + "})")
			}
            

        }
    }
}
