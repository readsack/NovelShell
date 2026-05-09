pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml


Singleton {
    Config{id: configFile}
    FileView {
        id: themeFile
        path: Qt.resolvedUrl(configFile.jsonData.themePath)
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
    }
    id: root
    property var theme: JSON.parse(themeFile.text())
    property var backgroundColor: theme.backgroundColor
    property var primaryTextColor: theme.primaryTextColor
    property var secondaryTextColor: theme.secondaryTextColor
    property var disabledColor: theme.disabledColor
    
    

}