import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Window


PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    id: bar
    implicitHeight: 40
    color: '#080808'
    
    PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}
    
    Item {
        anchors.fill: parent
        
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
                    color: isActive?"#ffffff":"#000000"
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
        Text {
            property bool showDate: false
            id: clock
            anchors.centerIn: parent
            color: "#ffffff"
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
        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: 20
            spacing: 20
            Text {
                
                color: "#ffffff"
                property var volume: Pipewire.defaultAudioSink?.audio.volume ?? 0
                text: "󰕾 %1%".arg(Math.trunc(volume * 100))
                font {
                    pixelSize: 16
                    weight: 700
                    family: "Iosevka Nerd Font"
                }
                MouseArea{
                    anchors.fill: parent
                    property var dir
                    onWheel: (wheel) => {
                        dir = wheel.angleDelta.y > 0 ? 1 : -1
                        Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(parent.volume + 0.05 * dir, 1.5));
                    }
                }
            }
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
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
                PopupWindow {
                    anchor.window: bar
                    anchor.rect.x: Screen.width - this.implicitWidth - 20
                    anchor.rect.y: 40
                    implicitWidth: 200
                    implicitHeight: 50
                    visible: mouseArea.containsMouse
                    color: "#00000000"
                    Rectangle {
                        anchors.fill: parent
                        color: "#080808"
                        radius: 5
                        border {
                            width: 2
                            color: '#3d3d3d'
                        }
                        Text {
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
            
        }

    }

}