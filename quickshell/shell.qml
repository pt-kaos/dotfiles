// @ pragma UseQApplication
//
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland	//Hyprland IPC access
import QtQuick
import QtQuick.Layouts		//For RowLayout
//import "./modules/bar/"

ShellRoot {
	id: root

	property color colGrey: "#2f2f3f"
	property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colGrey2: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
	property color colRed: "#e89aa8"
	property color colGreen: "#374e29"
	
	property string fontFamily: "JetBrainsMono Nerd Font"

	property int fontSize: 13
	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property var modelData
			screen: modelData

			id: panel

			anchors {
				top: true
				left: true
				right: true
			}
			implicitHeight: 25
			color: "#861a1b26"

			RowLayout {
				anchors.fill: parent
				anchors.leftMargin: 14
				anchors.rightMargin: 14
				spacing: 8
				//anchors.margins: 2

				//anchors.centerIn: parent

				Workspaces {}

				Item { Layout.fillWidth: true }

				RowLayout {
					spacing: 15
					
					Network {}
					Mem {}
					Cpu {}
					Volume {}
					Battery {}
					Clock {}
				}

			}




		}
	}
	//Loader {
	//	active: true
	//	sourceComponent: bar
	//}
}

//FloatingWindow{
//	visible: true
//	width: 200
//	height: 100
//
//	//anchors.centerIn center within parent
//	Text {
//		anchors.centerIn: parent
//		text: "Hello, Quickshell!"
//		color: "#6db9d7"
//		font.pixelSize: 18
//	}
//}
