import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Bluetooth
import "./Panels/"

Text{
    id: blue_module
    color: Theme.primaryTextColor
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    property bool showPanel: false
    
    text: ""
    MouseArea {
        anchors.fill: parent
        onClicked: {
            blue_module.showPanel = !blue_module.showPanel
            blue_panel_grab.active = blue_module.showPanel

        }
    }
    HyprlandFocusGrab {
            id: blue_panel_grab
            windows: [ blue_panel ]
            onCleared: {
                blue_module.showPanel = false
            }
    }
    BluePanel {
        id: blue_panel
        showPanel: blue_module.showPanel
    }
    

    
}
