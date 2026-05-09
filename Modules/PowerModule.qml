import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import "./Panels"



Text {
    id: power_module
    color: Theme.primaryTextColor
    property var power: UPower.displayDevice.percentage
    property var icon: UPower.displayDevice.timeToEmpty == 0? "󱟠" : "󱟞" 
    property bool charging: UPower.displayDevice.timeToEmpty == 0 
    property var chargingTime: UPower.displayDevice.timeToFull
    property var emptyTime: UPower.displayDevice.timeToEmpty
    property bool showPanel: false 
    text: "%2 %1%".arg(Math.trunc(power*100)).arg(icon)
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: { 
            parent.showPanel = !parent.showPanel 
            power_panel_grab.active = parent.showPanel
        }
    }
    HyprlandFocusGrab {
            id: power_panel_grab
            windows: [ power_panel ]
            onCleared: {
                power_module.showPanel = false
            }
        }
    PowerPanel {
        id: power_panel
        power_module: power_module
    }
    
    
}
            