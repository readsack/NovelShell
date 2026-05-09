import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Bluetooth
import "../Widgets"
import "../"


PanelWindow {
        required property bool showPanel
        id: blue_panel
        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
        }
        implicitWidth: 450
        implicitHeight: 250
        margins.right: showPanel ? 10 : -implicitWidth - 50
        color: "transparent"
        visible: true
        property var adapter: Bluetooth.defaultAdapter
        property var connected: false
        Rectangle {
            color: Theme.backgroundColor
            anchors.fill: parent
            radius: 5
            ColumnLayout {
                implicitHeight: 280
                implicitWidth: 400
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                Rectangle {
                    clip: true
                    implicitWidth: parent.width - 20
                    implicitHeight: 20
                    color: "transparent"
                    Row {
                        anchors.verticalCenter: parent.verticalCenter                    
                        Text {
                            text: "Devices List"
                            color: Theme.primaryTextColor
                            font {
                                pixelSize: 17
                                weight: 400
                                family: "Iosevka Nerd Font"
                            }
                            
                        }
                        Text {
                            text: " (scanning)"
                            visible: blue_panel.adapter.discovering
                            color: Theme.primaryTextColor
                            font {
                                pixelSize: 17
                                weight: 400
                                family: "Iosevka Nerd Font"
                            }
                        }
                    }
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        implicitWidth: 20
                        anchors.right: parent.right
                        Text {
                            anchors.centerIn: parent
                            color: Theme.primaryTextColor
                            text: !blue_panel.adapter.discovering ? "󰑓": ""
                            font {
                                pixelSize: 15
                                weight: 400
                                family: "Iosevka Nerd Font"
                            }
                                        
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    blue_panel.adapter.discovering = !blue_panel.adapter.discovering
                                }
                            }
                        }
                    }
                    
                }
                Rectangle {
                    implicitWidth: parent.implicitWidth
                    implicitHeight: 10
                    color: "transparent"
                    Rectangle {
                        anchors.centerIn: parent
                        implicitWidth: parent.implicitWidth
                        implicitHeight: 2
                    }
                }
                ScrollView {
                    implicitHeight: 160
                    clip: true
                    implicitWidth: parent.implicitWidth
                    Column {
                        anchors.centerIn: parent

                        spacing: 10
                        
                        
                        Repeater {
                            model: blue_panel.adapter.devices.values
                            BlueDeviceWidget{}
                            
                        }
                        
                    }
                }
            }
        }
        
    }