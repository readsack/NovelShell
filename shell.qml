import Quickshell
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

Scope {
    Bar{}
    IpcHandler {
        target: "launcher"
        function showL() {
            launcher_grab.active = true
            app_launcher.visible = true
        }
        function lock() {
            lock.locked = true
            pam_ctx.start()
        }
    }

    PanelWindow {
        id: app_launcher
        color: "transparent"
        implicitWidth: 500
        implicitHeight: 300
        HyprlandFocusGrab {
            id: launcher_grab
            windows: [ app_launcher ]
            onCleared: {
                app_launcher.visible = false
            }
            active: true
        }
        visible: launcher_grab.active

        ScriptModel {
            id: filtered_apps
            values: DesktopEntries.applications.values.filter(d => d.name && d.name.toLowerCase().includes(search_box.text));
        }        

        Rectangle {
            anchors.fill: parent
            radius: 8
            color: Theme.backgroundColor
            ColumnLayout {
                anchors.fill: parent
                Rectangle {
                    TextField {
                        id: search_box
                        anchors.fill: parent
                        implicitHeight: 20
                        placeholderText: "Enter App Name..."
                        placeholderTextColor : Theme.secondaryTextColor
                        background: Rectangle {
                            color: "transparent"
                        }
                        color: Theme.primaryTextColor
                        
                        font {
                            pixelSize: 20
                            weight: 700
                            family: "Iosevka Nerd Font"
                            
                        }
                        focus: true
                        onAccepted: {
                            filtered_apps.values[0].execute()
                            app_launcher.visible = false
                            launcher_grab.active = false
                            
                        }
                    }
                    implicitWidth: 400
                    implicitHeight: 60
                    Layout.alignment: Qt.AlignHCenter
                    
                    color: "transparent"
                    Rectangle {
                        implicitWidth: 400
                        implicitHeight: 3
                        color: Theme.primaryTextColor
                        anchors.bottom: parent.bottom
                    }
                }
                ScrollView {
                    
                    Layout.fillHeight: true
                    implicitWidth: 400
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    Layout.alignment: Qt.AlignHCenter
                    ColumnLayout {
                        anchors.centerIn: parent
                        implicitWidth: 400
                        implicitHeight: parent.height
                        spacing: 20
                        Repeater {
                            model: filtered_apps
                                WrapperMouseArea {
                                    RowLayout {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.preferredWidth: 350
                                        clip: true
                                        
                                        Rectangle {
                                            implicitHeight: 20
                                            implicitWidth: 20
                                            color: "transparent"
                                            Image {
                                                source: Quickshell.iconPath(modelData.icon)
                                                
                                                width: 20
                                                height: 20
                                                anchors.centerIn: parent
                                            }
                                        }
                                        
                                        Text {
                                            color: Theme.primaryTextColor
                                            font {
                                                pixelSize: 14
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                            text: modelData.name
                                        }
                                        Item {
                                            Layout.fillWidth: true
                                        }
                                        
                                    }
                                    onClicked: {
                                        app_launcher.visible = false
                                        launcher_grab.active = false
                                        modelData.execute()
                                    }
                                }
                        }
                    }
                }
                Item {
                    Layout.fillHeight: true
                }
            }
            
        }
    }
    PamContext {
        id: pam_ctx
        active: false
        onCompleted: (r) => {
            if (r == PamResult.Success){
                console.log("auth complete")
                lock.locked = false
            }
            else {
                lock.error = true
                pam_error_timer.running = true
                pam_ctx.start()

            }
            
        }
    }

    Timer {
        id: pam_error_timer
        interval: 2000
        running: false
        onTriggered: {
            lock.error = false
        }
    }
    WlSessionLock {
        id: lock
        property var error: false
        locked: false
        WlSessionLockSurface {
            color: "transparent"

            Image {
                id: lock_bg
                source: "/home/readsack/Wallpaper/wallhaven-lyqxqq_2880x1800.png"
                anchors.fill: parent
                visible: false
            }
            MultiEffect {
                anchors.fill: parent
                source: lock_bg
                blurEnabled: true
                blur: 1
                blurMultiplier: 2
            }
            ColumnLayout {
                implicitHeight: 90
                implicitWidth: 400
                anchors.centerIn: parent
                
                TextField {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    background: Rectangle {
                        color: Theme.backgroundColor 
                        radius: 10
                    }
                    padding: 20
                    id: session_lock_field
                    onAccepted: {
                        pam_ctx.respond(session_lock_field.text)
                    }
                    color: !lock.error? Theme.primaryTextColor : '#ff4242'
                    Behavior on color {
                        PropertyAnimation {duration: 100}
                    }
                    horizontalAlignment: Text.AlignHCenter
                    font {
                        pixelSize: 24
                        weight: 700
                        family: "Iosevka Nerd Font"        
                    }
                }
                
            }
            
            Button {
                text: "unlock"
                onClicked: lock.locked = false
            }
        }
    }
}
