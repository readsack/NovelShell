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
import "./Panels"

    
Text {
    PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}
    
    id: audio_module
    property bool showPanel: false 
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
        onClicked: {
            parent.showPanel = !parent.showPanel
            audio_panel_grab.active = parent.showPanel
        }
        property var dir
        onWheel: (wheel) => {
            dir = wheel.angleDelta.y > 0 ? 1 : -1
            Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(parent.volume + 0.05 * dir, 1.5));
        }
    }
    HyprlandFocusGrab {
            id: audio_panel_grab
            windows: [ audio_panel ]
            onCleared: {
                audio_module.showPanel = false
            }
    }
    AudioPanel {
        id: audio_panel
    }
}
