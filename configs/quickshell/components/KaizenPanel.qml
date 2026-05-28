import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

PanelWindow {
    id: panel

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 360
    color: "transparent"
    visible: root.kaizenPanelVisible

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: 0

    Rectangle {
        id: card
        width: 300
        height: 430
        radius: 24
        color: Qt.rgba(zyuTheme.bar_bg.r, zyuTheme.bar_bg.g, zyuTheme.bar_bg.b, 0.88)
        border.color: Qt.rgba(zyuTheme.border.r, zyuTheme.border.g, zyuTheme.border.b, 0.34)
        border.width: 1

        anchors.left: parent.left
        anchors.leftMargin: 64
        anchors.verticalCenter: parent.verticalCenter

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 12

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                    text: "KAIZEN"
                    color: zyuTheme.accent
                    font.family: "JetBrains Mono"
                    font.pixelSize: 18
                    font.bold: true
                }

                Text {
                    text: "Adaptive Control Panel"
                    color: Qt.rgba(zyuTheme.bar_fg.r, zyuTheme.bar_fg.g, zyuTheme.bar_fg.b, 0.62)
                    font.family: "JetBrains Mono"
                    font.pixelSize: 11
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                radius: 1
                color: Qt.rgba(zyuTheme.bar_fg.r, zyuTheme.bar_fg.g, zyuTheme.bar_fg.b, 0.08)
            }

            GridLayout {
                Layout.fillWidth: true
                columns: 2
                columnSpacing: 10
                rowSpacing: 10

                KaizenButton {
                    label: "Stable"
                    sublabel: "Waybar"
                    onClicked: Hyprland.dispatch("exec kaizen-quickshell-mode disable")
                }

                KaizenButton {
                    label: "Adaptive"
                    sublabel: "QML"
                    onClicked: Hyprland.dispatch("exec kaizen-quickshell-mode restart")
                }

                KaizenButton {
                    label: "Wallpaper"
                    sublabel: "Picker"
                    onClicked: {
                        root.kaizenPanelVisible = false
                        Hyprland.dispatch("exec bash ~/.config/hypr/scripts/kaizen-wallpaper-picker.sh")
                    }
                }

                KaizenButton {
                    label: "Tools"
                    sublabel: "Menu"
                    onClicked: {
                        root.kaizenPanelVisible = false
                        Hyprland.dispatch("exec bash ~/.config/hypr/scripts/kaizen-tools.sh")
                    }
                }

                KaizenButton {
                    label: "Update"
                    sublabel: "Kaizen"
                    onClicked: Hyprland.dispatch("exec kitty -e bash -lc 'KAIZEN_BRANCH=full-rice-integration kaizen-update; echo; read -rp \"Press Enter to close...\"'")
                }

                KaizenButton {
                    label: "Lock"
                    sublabel: "Screen"
                    onClicked: {
                        root.kaizenPanelVisible = false
                        Hyprland.dispatch("exec hyprlock")
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                SmallButton {
                    text: "Reboot"
                    onClicked: Hyprland.dispatch("exec systemctl reboot")
                }

                SmallButton {
                    text: "Power off"
                    onClicked: Hyprland.dispatch("exec systemctl poweroff")
                }
            }

            Text {
                Layout.fillWidth: true
                text: "Experimental Adaptive Mode"
                horizontalAlignment: Text.AlignHCenter
                color: Qt.rgba(zyuTheme.bar_fg.r, zyuTheme.bar_fg.g, zyuTheme.bar_fg.b, 0.36)
                font.family: "JetBrains Mono"
                font.pixelSize: 10
            }
        }
    }

    component KaizenButton: Rectangle {
        id: btn
        property string label: ""
        property string sublabel: ""
        signal clicked()

        Layout.fillWidth: true
        Layout.preferredHeight: 78
        radius: 18
        color: mouse.containsMouse
            ? Qt.rgba(zyuTheme.accent.r, zyuTheme.accent.g, zyuTheme.accent.b, 0.18)
            : Qt.rgba(zyuTheme.widget_bg.r, zyuTheme.widget_bg.g, zyuTheme.widget_bg.b, 0.72)

        border.color: mouse.containsMouse
            ? Qt.rgba(zyuTheme.accent.r, zyuTheme.accent.g, zyuTheme.accent.b, 0.36)
            : Qt.rgba(zyuTheme.border.r, zyuTheme.border.g, zyuTheme.border.b, 0.28)

        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 4

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: btn.label
                color: zyuTheme.bar_fg
                font.family: "JetBrains Mono"
                font.pixelSize: 13
                font.bold: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: btn.sublabel
                color: Qt.rgba(zyuTheme.bar_fg.r, zyuTheme.bar_fg.g, zyuTheme.bar_fg.b, 0.48)
                font.family: "JetBrains Mono"
                font.pixelSize: 10
            }
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: btn.clicked()
        }
    }

    component SmallButton: Rectangle {
        id: small
        property alias text: smallText.text
        signal clicked()

        Layout.fillWidth: true
        Layout.preferredHeight: 34
        radius: 999
        color: mouse.containsMouse
            ? Qt.rgba(zyuTheme.accent.r, zyuTheme.accent.g, zyuTheme.accent.b, 0.18)
            : Qt.rgba(zyuTheme.widget_bg.r, zyuTheme.widget_bg.g, zyuTheme.widget_bg.b, 0.62)

        border.color: Qt.rgba(zyuTheme.border.r, zyuTheme.border.g, zyuTheme.border.b, 0.28)
        border.width: 1

        Text {
            id: smallText
            anchors.centerIn: parent
            color: zyuTheme.bar_fg
            font.family: "JetBrains Mono"
            font.pixelSize: 10
            font.bold: true
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: small.clicked()
        }
    }
}
