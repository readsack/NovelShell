import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Networking

import "./Modules"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    id: bar
    implicitHeight: 40
    color: '#00080808'
    margins {
        top: 10
        left: 10
        right: 10
    }
    
    
    Rectangle {
        anchors.fill: parent
        color: "#080808"
        radius: 10
        Item {
        anchors.fill: parent
        id: items
        Workspaces{}
        ClockModule{}
        Row {
            id: system_info
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: 20
            spacing: 20
            
            AudioModule{}
            PowerModule{}
            BluetoothModule{}
            WifiModule{}
            SysTrayModule{}
            NotificationModule{}
        }
        
    }
    }
    

}

