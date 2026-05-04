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
        id: items
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
            id: system_info
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: 20
            spacing: 20
            Text {
                id: audio_module
                property bool show: false 
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
                    onClicked: parent.show = !parent.show
                    property var dir
                    onWheel: (wheel) => {
                        dir = wheel.angleDelta.y > 0 ? 1 : -1
                        Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(parent.volume + 0.05 * dir, 1.5));
                    }
                }

                PopupWindow {
                    id: audio_player_popup
                    implicitWidth: 300
                    implicitHeight: 150
                    anchor.window: bar
                    anchor.rect.x: Screen.width
                    anchor.rect.y: 50
                    visible: audio_module.show
                    color: "#00000000"
                    Rectangle {

                        ColumnLayout {
                            anchors.fill: parent
                            Repeater {
                                model: Mpris.players.values
                                Item{
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                    Layout.minimumHeight: 150
                                    property var player: Mpris.players.values[index]
                                    visible: player.playbackState == MprisPlaybackState.Paused || player.playbackState == MprisPlaybackState.Playing 
                                    Text {
                                        id: playerName
                                        text: Mpris.players.values[index].identity
                                        anchors.centerIn: parent
                                        color: "#ffffff"
                                        font {
                                            pixelSize: 16
                                            weight: 700
                                        }
                                    }
                                    FrameAnimation {
                                        running: player.playbackState == MprisPlaybackState.Playing
                                        onTriggered: player.positionChanged()
                                    }
                                    ProgressBar{
                                        id: audio_progress
                                        anchors.top: playerName.bottom
                                        anchors.margins: 10
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        background: Rectangle{
                                            color: '#6bffffff'
                                            implicitHeight: 5
                                            implicitWidth: 200
                                        }
                                        contentItem: Item {
                                            implicitHeight: 5
                                            implicitWidth: 200 * audio_progress.visualPosition
                                            Rectangle {
                                                color: "#ffffff"
                                                width: audio_progress.visualPosition * parent.width
                                                height: parent.height
                                            }
                                        }
                                        value: Mpris.players.values[index].position/Mpris.players.values[index].length
                                    }

                                }
                            }
                        }
                        anchors.fill: parent
                        color: "#9c000000"
                        border {
                            width: 1
                            color: '#adadad'
                        }
                        
                    }
                    
                }

            }
            
            PowerModule{}
            
        }
        
    }

}

