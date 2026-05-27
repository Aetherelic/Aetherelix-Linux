import QtQuick
import Quickshell

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 34
        color: "transparent"

        Rectangle {
            anchors.centerIn: parent
            width: 360
            height: 24
            radius: 999
            color: "#cc06080c"
            border.color: "#335f4dff"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "Kaizen Adaptive Shell"
                color: "#f4f2ff"
                font.pixelSize: 12
                font.family: "JetBrains Mono"
            }
        }
    }
}
