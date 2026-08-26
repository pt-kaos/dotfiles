import Quickshell
import QtQuick

FloatingWindow{
	visible: true
	width: 200
	height: 100

	//anchors.centerIn center within parent
	Text {
		anchors.centerIn: parent
		text: "Hello, Quickshell!"
		color: "#6db9d7"
		font.pixelSize: 18
	}
}
