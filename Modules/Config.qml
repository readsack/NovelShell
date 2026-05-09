import Quickshell
import Quickshell.Io
import QtQml
import QtQuick

Item {
    readonly property var jsonData: JSON.parse(configFile.text())

    FileView {
        id: configFile
        path: Qt.resolvedUrl("../config/config.json")
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
    }
}