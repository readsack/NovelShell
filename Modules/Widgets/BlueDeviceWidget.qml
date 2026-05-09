import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Bluetooth
import Quickshell.Widgets
import "../"

WrapperMouseArea{
    implicitHeight: 20
    implicitWidth: 400
    RowLayout {
        implicitHeight: 20
        implicitWidth: 400
        id: blue_device
        
        property var device: Bluetooth.defaultAdapter.devices.values[index]
        Text {
            color: Theme.primaryTextColor
            text: parent.device.name
            font {
                pixelSize: 14
                weight: 400
                family: "Iosevka Nerd Font"
            }
            width: 150
            elide: Text.ElideRight
        }
        
        Text {
            color: Theme.primaryTextColor
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: parent.device.connected 
                        ? "󰂱"
                        : parent.device.state === BluetoothDeviceState.Connecting 
                                ? "󰂰" 
                                : ""
            font {
                pixelSize: 14
                weight: 600
                family: "Iosevka Nerd Font"
            }
        }

        Text {
            width: 100
            visible: parent.device.connected
            color: Theme.primaryTextColor
            text: "%1%".arg(Math.trunc(parent.device.battery * 100))
            font {
                pixelSize: 14
                weight: 600
                family: "Iosevka Nerd Font"
            }
        }
    }                             
    onClicked: {
        if(blue_device.device.state == BluetoothDeviceState.Connected){
            blue_device.device.disconnect()
        }
        if(blue_device.device.state == BluetoothDeviceState.Disconnected){
            blue_device.device.connect()
        }
    }

}