import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Window
import Quickshell.Services.Notifications
import QtQuick.Layouts

Text {
    id: notif_module
    property bool showPanel: false
    color: "#ffffff"
    font {
        pixelSize: 14
        weight: 700
        family: "Iosevka Nerd Font"
    }
    text: ""
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.showPanel = !parent.showPanel
            notif_panel_grab.active = parent.showPanel
        }
    }
    NotificationServer{
        id: notif_server
        onNotification:(n)=>{
                n.tracked = true
                notification_item.notif = n
                notif_timer.running = true
                notification_item.show_notif = true
        }
    }
    HyprlandFocusGrab {
            id: notif_panel_grab
            windows: [ notif_panel ]
            onCleared: {
                notif_module.showPanel = false
            }
    }
    PanelWindow {
        id: notification_item
        property bool show_notif: false
        property var notif: null

        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
            right: show_notif ? 10 : -implicitWidth - 50

        }
        implicitWidth: 270
        implicitHeight: 75

        color: "#00000000"
        Rectangle {
            anchors.fill: parent
            radius: 10
            color: "#080808"
            Column {
                anchors.fill: parent
                anchors.margins: 10
                                        Text {

                                            color: "#ffffff"
                                            text: notification_item.notif.summary
                                            font {
                                                pixelSize: 15
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                        Text {
                                            color: "#ffffff"
                                            text: notification_item.notif.body
                                            width: 250 - 30
                                            
                                            elide: Text.ElideMiddle
                                            font {
                                                pixelSize: 14
                                                weight: 400
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                        Text {
                                            color: "#ffffff"
                                            text: "From: %1".arg(notification_item.notif.appName)
                                            font {
                                                pixelSize: 12
                                                weight: 400
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                    }
        }
        Timer {
            id: notif_timer
            interval: 2000
            running: false
            onTriggered: notification_item.show_notif = false
            
        }
    }
    
    PanelWindow {
        id: notif_panel
        anchors {
            right: true
            top: true
        }
        margins {
            top: 10
        }
        implicitWidth: 250
        implicitHeight: 300
        margins.right: notif_module.showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        Rectangle {
            anchors.fill: parent
            radius: 5
            color: "#080808"
            ColumnLayout {
                implicitWidth: parent.width - 20
                height: parent.height - 40
                anchors.centerIn: parent
                Text {
                    color: "#ffffff"
                    font {
                        pixelSize: 17
                        weight: 400
                        family: "Iosevka Nerd Font"
                    }
                    text: "Notifications"
                }
                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 10
                    color: "#00ffffff"
                    Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 2
                    }
                }
                Item {
                    Layout.fillHeight: true
                    implicitWidth: parent.width
                    ScrollView {
                        implicitHeight: parent.height
                        clip: true
                        ColumnLayout {
                            implicitWidth: 250
                            implicitHeight: parent.height
                            Repeater  {
                                model: notif_server.trackedNotifications.values
                                WrapperMouseArea{

                                    child: Column {
                                        Text {

                                            color: "#ffffff"
                                            text: modelData.summary
                                            font {
                                                pixelSize: 15
                                                weight: 700
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                        Text {
                                            color: "#ffffff"
                                            text: modelData.body
                                            width: 250 - 30
                                            wrapMode: Text.Wrap
                                            font {
                                                pixelSize: 14
                                                weight: 400
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                        Text {
                                            color: "#ffffff"
                                            text: "From: %1".arg(modelData.appName)
                                            font {
                                                pixelSize: 12
                                                weight: 400
                                                family: "Iosevka Nerd Font"
                                            }
                                        }
                                    }
                                    onClicked: {
                                        modelData.dismiss()
                                    }
                                }
                                
                                

                            }
                        }
                        
                    }
                }
            }
        }
    }
}