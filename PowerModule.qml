import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick.Controls
import QtQuick
import QtQuick.Window



Text {
    id: power_module
    color: "#ffffff"
    property var power: UPower.displayDevice.percentage
    property var icon: UPower.displayDevice.timeToEmpty == 0? "󱟠" : "󱟞" 
    property bool charging: UPower.displayDevice.timeToEmpty == 0 
    property var chargingTime: UPower.displayDevice.timeToFull
    property var emptyTime: UPower.displayDevice.timeToEmpty
    property bool showPanel: false 
    text: "%2 %1%".arg(Math.trunc(power*100)).arg(icon)
    font {
        pixelSize: 16
        weight: 700
        family: "Iosevka Nerd Font"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: parent.showPanel = !parent.showPanel 
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
        implicitHeight: 170
        margins.right: power_module.showPanel ? 10 : -implicitWidth - 50
        color: "#00000000"
        Rectangle {
            anchors.fill: parent
            color: "#080808"
            radius: 10
            Column{
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 20
                anchors.right: parent.right
                spacing: 10
                Text{
                    color: "#ffffff"
                    font {
                        pixelSize: 16
                        weight: 700
                        family: "Iosevka Nerd Font"
                    }
                    text: "%2 : %1% %3".arg(Math.trunc(power_module.power*100)).arg(power_module.icon).arg(power_module.charging?"(Charging)":"(Discharging)")
                    
                }
                Text{
                    property var timetoShow: power_module.charging ? power_module.chargingTime : power_module.emptyTime
                    property var timeText: "%1H %2M".arg(Math.trunc(timetoShow/3600)).arg(Math.trunc((timetoShow%3600)/60))
                    color: "#ffffff"
                    font {
                        pixelSize: 16
                        weight: 700
                        family: "Iosevka Nerd Font"
                    }
                    text: "󱑀 : %1".arg(timeText)
                    
                }
                Text{
                    color: "#ffffff"
                    font {
                        pixelSize: 16
                        weight: 700
                        family: "Iosevka Nerd Font"
                    }
                    text: "⏻ : %1".arg(PowerProfile.toString(PowerProfiles.profile))
                    
                }
                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    id: profile_switcher
                    implicitWidth: 150
                    implicitHeight: 50
                    property var selected_el: PowerProfiles.profile == PowerProfile.PowerSaver? power_profile_1 : (PowerProfiles.profile == PowerProfile.Balanced ? power_profile_2 : power_profile_3) 
                    property var selected: PowerProfiles.profile == PowerProfile.PowerSaver ? 0 : (PowerProfiles.profile == PowerProfile.Balanced? 1 : 2) 

                    Rectangle {
                        x: parent.selected_el.x - parent.selected_el.width/2 - 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 50
                        height: 50
                        radius: 20
                        color: "#ffffff"

                        Behavior on x {
                            PropertyAnimation {duration: 100}
                        }
                    }

                    Text{
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        id: power_profile_1
                        color: profile_switcher.selected == 0 ? "#080808" :"#ffffff"
                        font {
                            pixelSize: 25
                            weight: 700
                            family: "Iosevka Nerd Font"
                        }
                        text: "󰌪"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                profile_switcher.selected = 0     
                                profile_switcher.selected_el = power_profile_1              
                                PowerProfiles.profile = PowerProfile.PowerSaver     

                            }
                        }
                        Behavior on color {
                            PropertyAnimation { duration: 100 }
                        }
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        id: power_profile_2
                        color: profile_switcher.selected == 1 ? "#080808" :"#ffffff"
                        font {
                            pixelSize: 25
                            weight: 700
                            family: "Iosevka Nerd Font"
                        }
                        text: "󰗑"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                profile_switcher.selected = 1
                                profile_switcher.selected_el = power_profile_2      
                                PowerProfiles.profile = PowerProfile.Balanced     
             
                            }
                        }
                        Behavior on color {
                            PropertyAnimation { duration: 100 }
                        }
                    }
                    Text{
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        id: power_profile_3
                        color: PowerProfiles.hasPerformanceProfile ? profile_switcher.selected == 2 ? "#080808" :"#ffffff" : "#666666"
                        font {
                            pixelSize: 25
                            weight: 700
                            family: "Iosevka Nerd Font"
                        }
                        text: "󱓞"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (PowerProfiles.hasPerformanceProfile){
                                    profile_switcher.selected_el = power_profile_3
                                    profile_switcher.selected = 2     
                                    PowerProfiles.profile = PowerProfile.Performance     
                                }         
                            }
                        }
                        Behavior on color {
                            PropertyAnimation { duration: 100 }
                        }
                    }
                    
                }
                
                
                
                

            }
            
        }
        
    }
    
}
            