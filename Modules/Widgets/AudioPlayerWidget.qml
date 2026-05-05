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

    

Column {
                    required property var player
                    required property var index
                    required property var selectedID
                    id: media_player
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    width: 200
                    clip: true
                    spacing: 10
                    Text {
                        color: "#ffffff"
                        font {
                            pixelSize: 17
                            weight: 300
                            family: "Iosevka Nerd Font"
                        }
                        width: 200
                        elide: Text.ElideRight 
                        text: player?.identity
                    }
                    
                    Rectangle {
                        id: track_image_cont
                        width: 50
                        height: 50
                        color: "transparent"
                        
                        NumberAnimation on rotation {
                                from: 0
                                to: 360
                                duration: 3000       // Speed (3 seconds per full rotation)
                                loops: Animation.Infinite
                                running: true
                            }
                        Image {
                            id: track_image
                            width:70
                            height: 70
                            anchors.centerIn: parent
                            source: player?.trackArtUrl// Replace with your image
                            fillMode: Image.PreserveAspectCrop
                            smooth: true                            
                            visible: false
                            z: -1
                        }
                        Rectangle {
                            id: track_image_placeholder
                            width: 70
                            height: 70
                            color: "#ffffff"
                            visible: false
                        }
                        OpacityMask {
                            anchors.fill: track_image_cont
                            source: (player?.trackArtUrl == "" ? track_image_placeholder : track_image)
                            maskSource: Rectangle {
                                width: track_image_cont.width
                                height: track_image_cont.height
                                radius: track_image_cont.width/2
                            }
                        }
                    }
                   
                    Column {
                        Text {
                            color: "#ffffff"
                            font {
                                pixelSize: 14
                                weight: 700
                                family: "Iosevka Nerd Font"
                            }
                            width: 200
                            elide: Text.ElideRight 
                            text: player?.trackTitle
                        }
                        Text {
                            color: "#ffffff"
                            font {
                                pixelSize: 14
                                weight: 300
                                family: "Iosevka Nerd Font"
                            }
                            width: 200
                            elide: Text.ElideRight 
                            text: player?.trackArtist
                        }
                    }
                    ProgressBar {
                        id: playback_progress_bar
                        value: player?.position/player?.length
                        contentItem: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 5
                            color: "#666666"
                            radius: 10
                            Rectangle {
                                implicitWidth: 200 * playback_progress_bar.visualPosition
                                implicitHeight: 5
                                color: "#ffffff"
                                radius: 10
                            }
                            
                        }
                        background: Rectangle {
                            color: "#080808"
                            implicitWidth: 200
                        }
                    }
                    Item {
                        width: parent.width
                        height: 30
                        Text {
                            property var disabled: !player?.canGoPrevious
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            color: disabled ?"#666666":"#ffffff"
                            text: "󰒮"
                            font {
                                pixelSize: 24
                                weight: 700
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if(!parent.disabled) {
                                        player?.previous()
                                    }
                                }
                            }
                        }
                        Text {
                            property var disabled: !player?.canTogglePlaying
                            property var isPlaying: !player?.isPlaying
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.leftMargin: 20
                            color: disabled ?"#666666":"#ffffff"
                            text: !isPlaying?"󰏤":"󰐊"
                            font {
                                pixelSize: 24
                                weight: 700
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if(!parent.disabled) {
                                        player?.togglePlaying()
                                    }
                                }
                            }
                        }
                        Text {
                            property var disabled: !player?.canGoNext
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            color: disabled ?"#666666":"#ffffff"
                            text: "󰒭"
                            font {
                                pixelSize: 24
                                weight: 700
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if(!parent.disabled) {
                                        player?.next()
                                    }
                                }
                            }
                        }
                        
                    }
                    Item {
                        height: 10
                        width: parent.width
                    }
                    
                }