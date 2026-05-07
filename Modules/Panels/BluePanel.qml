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
        implicitWidth: 350
        implicitHeight: 250
        margins.right: showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        visible: true
        property var adapter: Bluetooth.defaultAdapter
        property var connected: false
        Rectangle {
            color: "#080808"
            anchors.fill: parent
            radius: 10
            ColumnLayout {
                implicitHeight: 280
                implicitWidth: 300
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                Rectangle {
                    clip: true
                    implicitWidth: parent.width - 20
                    implicitHeight: 20
                    color: "#00000000"
                    Row {
                        anchors.verticalCenter: parent.verticalCenter                    
                        Text {
                            text: "Devices List"
                            color: "#ffffff"
                            font {
                                pixelSize: 17
                                weight: 400
                                family: "Iosevka Nerd Font"
                            }
                            
                        }
                        Text {
                            text: " (scanning)"
                            visible: blue_panel.adapter.discovering
                            color: "#ffffff"
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
                            color: "#ffffff"
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
                    color: "#00ffffff"
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
                            BlueDeviceWidget{

                            }
                            
                        }
                        
                    }
                }
            }
        }
        
    }