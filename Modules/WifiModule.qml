import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import Quickshell.Networking

Text{
    id: wifi_module
    color: Theme.primaryTextColor
    property var wifi: ""
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    Process {
        id: wifi_proc
        command: ["sh", "-c", "iw dev | grep ssid | cut -c8-"]
        stdout: StdioCollector {
            onStreamFinished: wifi_module.wifi = this.text
        }
        running: true
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: wifi_proc.running = true
    }
    text: "󰤨  %1".arg(wifi != ""?wifi:"(none)")
    MouseArea {
        anchors.fill: parent
    }

    
}