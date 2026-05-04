PopupWindow {
                id: popup
                // Only visible when the MouseArea is hovered
                visible: power_mod.containsMouse
                
                // Anchors the popup to the bar item
                anchor.window: bar
                anchor.rect.y: 40
                implicitWidth: popupText.implicitWidth + 30
                implicitHeight: popupText.implicitHeight + 10
                color: "#00000000"
                Rectangle {
                    implicitWidth: popupText.implicitWidth + 10
                    implicitHeight: popupText.implicitHeight + 10
                    color: '#9c000000'
                    border {
                        width: 1
                        color: '#adadad'
                        
                    }
                    radius: 3
                    Text {
                        id: popupText
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