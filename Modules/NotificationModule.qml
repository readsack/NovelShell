import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import Quickshell.Services.Notifications
import QtQuick.Layouts

Text {
    id: systray_module
    property bool showPanel: false
    color: "#ffffff"
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    text: ""
    MouseArea {
        anchors.fill: parent
        onClicked: parent.showPanel = !parent.showPanel
    }
    PanelWindow {
        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
        }
        implicitWidth: 250
        implicitHeight: 250
        margins.right: systray_module.showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        Rectangle {
            anchors.fill: parent
            radius: 10
            color: "#080808"
            ColumnLayout {
                implicitWidth: parent.width - 20
                height: parent.height - 40
                anchors.centerIn: parent
                Text {
                    color: "#ffffff"
                    font {
                        pixelSize: 17
                        weight: 400
                        family: "Iosevka Nerd Font"
                    }
                    text: "Notifications"
                }
                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 10
                    color: "#00ffffff"
                    Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 2
                    }
                }
                Item {
                    Layout.fillHeight: true
                    implicitWidth: parent.width
                    ScrollView {
                        implicitHeight: parent.height
                        implicitWidth: parent.width
                        clip: true
                        Repeater  {
                            model: NotificationServer.trackedNotifications.values
                            RowLayout {
                                implicitWidth: parent.width
                                implicitHeight: 50
                                
                                Text {
                                    color: "#ffffff"
                                    font {
                                        pixelSize: 14
                                        weight: 700
                                        family: "Iosevka Nerd Font"
                                    }
                                    text: NotificationServer.trackedNotifications?.values[index].body
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
}