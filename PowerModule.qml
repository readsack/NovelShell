import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Window



Text {
    id: power_module
    color: "#ffffff"
    property var power: UPower.displayDevice.percentage
    property var icon: UPower.displayDevice.timeToEmpty == 0? "󱟠" : "󱟞" 
    property bool charging: UPower.displayDevice.timeToEmpty == 0 
    property var chargingTime: UPower.displayDevice.timeToFull
    property var emptyTime: UPower.displayDevice.timeToEmpty
    text: "%2 %1%".arg(Math.trunc(power*100)).arg(icon)
    font {
        pixelSize: 16
        weight: 700
        family: "Iosevka Nerd Font"
    }
    MouseArea{
        id: power_mod
        anchors.fill: parent
        hoverEnabled: true
    }
    PopupWindow {
                id: power_display
                visible: power_mod.containsMouse
                anchor.window: bar
                anchor.rect.y: 40
                anchor.rect.x: Screen.width - 100
                implicitWidth: popupText.implicitWidth + 30
                implicitHeight: popupText.implicitHeight + 15
                color: "#00000000"
                Rectangle {
                    implicitWidth: popupText.implicitWidth + 15
                    implicitHeight: popupText.implicitHeight + 15
                    color: '#9c000000'
                    border {
                        width: 1
                        color: '#adadad'
                        
                    }
                    radius: 3
                    Text {
                        id: popupText
                            property var show_val: power_module.charging? power_module.chargingTime : power_module.emptyTime
                            property var show_text: power_module.charging? "Full In: ": "Time Left: "
                            property var hour: Math.trunc(show_val/3600)
                            property var minute: Math.trunc((show_val%3600)/60)
                            text: "%1 %2H %3M".arg(show_text).arg(hour).arg(minute)
                            color: "#ffffff"
                            anchors.centerIn: parent
                            font {
                                pixelSize: 14
                                weight: 700
                        }
        }
    }
}
}
            