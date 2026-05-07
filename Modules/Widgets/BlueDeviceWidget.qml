import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Bluetooth

Rectangle {
    implicitHeight: 20
    implicitWidth: 300
    id: blue_device
    color: "#00000000"
    radius: 10
    property var device: Bluetooth.defaultAdapter.devices.values[index]
    Text {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
                                    color: "#ffffff"
                                    text: parent.device.name
                                    font {
                                        pixelSize: 14
                                        weight: 400
                                        family: "Iosevka Nerd Font"
                                    }
                                }
                                Text {
                                    anchors.right: parent.right
                                    anchors.rightMargin: 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "#ffffff"
                                    text: parent.device.connected 
                                                ? "connected" 
                                                : parent.device.state === BluetoothDeviceState.Connecting 
                                                        ? "connecting" 
                                                        : parent.device.state === BluetoothDeviceState.Disconnecting
                                                                ? "disconnecting"
                                                                : ""
                                    font {
                                        pixelSize: 14
                                        weight: 600
                                        family: "Iosevka Nerd Font"
                                    }
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if(parent.device.state == BluetoothDeviceState.Connected){
                                            parent.device.disconnect()
                                        }
                                        if(parent.device.state == BluetoothDeviceState.Disconnected){
                                            parent.device.connect()
                                        }
                                    }
                                }
                            }