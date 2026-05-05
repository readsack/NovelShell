import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import Quickshell.Networking

Text{
    id: wifi_module
    color: "#ffffff"
    font {
        pixelSize: 16
        weight: 700
        family: "Iosevka Nerd Font"
    }
    property bool showPanel: false
    property string icon: Networking.connectivity == NetworkConnectivity.Full ? "󰤨" : Networking.connectivity == NetworkConnectivity.Limited ? "󰤩" : "󰤭"
    
    text: icon
    MouseArea {
        anchors.fill: parent
        onClicked: wifi_module.showPanel = !wifi_module.showPanel
    }

    

    PanelWindow {
        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
        }
        implicitWidth: 250
        implicitHeight: 250
        margins.right: wifi_module.showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        visible: true
        Rectangle {
            color: "#080808"
            anchors.fill: parent
            radius: 10
        }
    }
}