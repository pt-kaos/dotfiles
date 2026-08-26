import Quickshell
import QtQuick

Text {
	text: Qt.formatDateTime(clock.date, "hh:mm")
	//anchors{
	//	right: parent
	//	margins: 8
	//}

	//color: "#e5f2c5"
	color: "#3da160"

	font {
		family: "SF Mono"
		letterSpacing: -0.5
		pixelSize: 13
		weight: 700
	}


	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}


