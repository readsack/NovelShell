import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Effects
import QtQuick.Window
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Services.Pam

import Quickshell.Networking
import Quickshell.Wayland
import Quickshell.Widgets

import "./Modules"
Variants {
    model: Quickshell.screens
PanelWindow {
    required property var modelData
    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }
    id: bar
    implicitHeight: 40
    color: '#00080808'
    
    IdleInhibitor {
        id: idle_inhibitor
        window: bar
        enabled: false
    }
    
    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundColor
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
                Text {
                    id: idle_module
                    color: Theme.primaryTextColor
                    font {
                        pixelSize: 14
                        weight: 700
                        family: "Iosevka Nerd Font"
                    }
                    text: idle_inhibitor.enabled? "󰅶" : "󰾪"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            idle_inhibitor.enabled = !idle_inhibitor.enabled
                        }
                    }
                }
            }
        }

    }
    
        

}
}

