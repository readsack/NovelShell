import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import Quickshell.Services.SystemTray
import QtQuick.Layouts

Text {
    id: systray_module
    property bool showPanel: false
    color: Theme.primaryTextColor
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    text: ""
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.showPanel = !parent.showPanel
            systray_grab.active = systray_module.showPanel
        }
    }
    HyprlandFocusGrab {
        id: systray_grab 
        windows: [ systray_panel ]
        onCleared: {
            systray_module.showPanel = false
        }
    }
    PanelWindow {
        id: systray_panel
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
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            radius: 5
            color: Theme.backgroundColor
            ColumnLayout {
                implicitWidth: parent.width - 20
                height: parent.height - 40
                anchors.centerIn: parent
                Text {
                    color: Theme.primaryTextColor
                    font {
                        pixelSize: 17
                        weight: 400
                        family: "Iosevka Nerd Font"
                    }
                    text: "System Tray"
                }
                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 10
                    color: "transparent"
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
                        Column {
                            width: parent.width
                            spacing:10
                            Repeater  {
                                model: SystemTray.items.values
                                
                                Item {
                                    implicitWidth: parent.width
                                    implicitHeight: 20
                                    Row {
                                        spacing: 5
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.left: parent.left
                                        Text {
                                            color: Theme.primaryTextColor
                                            font {
                                                pixelSize: 14
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                            text: ""
                                            visible: SystemTray.items.values[index].hasMenu
                                        }
                                        Rectangle {
                                            implicitWidth: 20
                                            implicitHeight: 20
                                            color: "transparent"
                                            Image {
                                                source: SystemTray.items.values[index].icon
                                                width: 20
                                                height: 20
                                            }
                                        }
                                        Text {
                                            color: Theme.primaryTextColor
                                            font {
                                                pixelSize: 14
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                            text: SystemTray.items.values[index].tooltipTitle == "" ? SystemTray.items.values[index].title : SystemTray.items.values[index].tooltipTitle
                                        }
                                        
                                        Text {
                                            color: Theme.primaryTextColor
                                            font {
                                                pixelSize: 14
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                            text: "<*>"
                                            visible: SystemTray.items.values[index].status === Status.NeedsAttention

                                        }
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            SystemTray.items.values[index].activate()
                                        }
                                    }
                                }

                            }
                        }
                        
                    }
                }
            }
        }
    }
    
}