import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
	id: panel

	anchors {
		top: true
		left: true
		right: true
	}
	implicitHeight: 30
	margins {
		top: 2
		left: 2
		right: 2
	}

	Rectangle {
		id: bar
		anchors.fill: parent
		color: #1a1a1a
		radius: 15
		border.color: "#333333"
		border.width: 3

		row {
			id: workspacesRow
			
			anchors {
				left.parent.left
				verticalCenter: parent.verticalCenter
				leftMargin: 16
			}
			spacing: 8

			Repeater {
				model: Hyprland.workspaces

				Text {
					property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
					property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

					text: modelData.id
					color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
					font: { pixelSize: 14; bold: true }
					anchors.centerIn: parent

					MouseArea {
						anchors.fill: parent
						onClicked: Hyprland.dispatch("workspaces " + (index + 1))
					}
				}
			}
			
		}
	}

}

