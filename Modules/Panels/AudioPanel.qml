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
import Qt5Compat.GraphicalEffects
import "../Widgets"

PanelWindow {
        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
        }

        
        
        Connections {
            function onObjectRemovedPre(object, idx) {
                audio_playback_widget.selectedID = 0
                audio_playback_widget.player = Mpris.players.values[audio_playback_widget.selectedID]
            }
            target: Mpris.players
        }
        implicitWidth: 250
        implicitHeight: 50 + 210
        margins.right: audio_module.showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        Rectangle {
            id: audio_playback_widget
            property var selectedID: 0
            property var player: Mpris.players.values[selectedID]

            anchors.fill: parent
            color: "#080808"
            radius: 5
            //Player Selector
            Item {
                width: parent.width - 30
                anchors.horizontalCenter: parent.horizontalCenter
                height: 50
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    color:"#ffffff"
                    text: ""
                    font {
                        pixelSize: 14
                        weight: 300
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(audio_playback_widget.selectedID > 0) audio_playback_widget.selectedID = audio_playback_widget.selectedID - 1
                            audio_playback_widget.player = Mpris.players.values[audio_playback_widget.selectedID]

                        }
                    }
                }
                Text {
                    anchors.centerIn: parent
                    anchors.leftMargin: 20
                    color:"#ffffff"
                    text: audio_playback_widget.selectedID + 1
                    font {
                        pixelSize: 14
                        weight: 300
                    }
                    
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    color:"#ffffff"
                    text: ""
                    font {
                        pixelSize: 14
                        weight: 300
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(audio_playback_widget.selectedID < Mpris.players.values.length - 1) audio_playback_widget.selectedID = audio_playback_widget.selectedID + 1
                            audio_playback_widget.player = Mpris.players.values[audio_playback_widget.selectedID]

                        }
                    }
                }
                        
                        
            }
            AudioPlayerWidget {
                player: audio_playback_widget.player
                selectedID: audio_playback_widget.selectedID
            }
        }
    }