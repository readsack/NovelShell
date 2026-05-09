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

Row {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5
    leftPadding: 20
    Repeater {
        model: Hyprland.workspaces.values.length                
        Rectangle {
            width: 20
            height: 20
            property var ws: Hyprland.workspaces.values[index]
            property bool isActive: Hyprland.focusedWorkspace?.id === ws.id    
            color: isActive?"#ffffff":'#07000000'
            radius: 3
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace %1".arg(ws.id))
            }
            Text {
                color: isActive?"#000000":"#ffffff"
                anchors.centerIn: parent
                text: ws.id
                font {
                    weight: 700
                }
            }
        }
    }
}