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

Text {
    property bool showDate: false
    id: clock
    anchors.centerIn: parent
    color: Theme.primaryTextColor
    font {
        weight: 700
        pixelSize: 14
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.showDate = !parent.showDate
            dateProc.running = true
        }
    }

    Process {
        id: dateProc
        command: clock.showDate?["date", "+%d %a, %G"]:["date", "+%H:%M"]
        running: true
                
        stdout: StdioCollector {
        onStreamFinished: clock.text = this.text
    }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}