import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0
import "components"

Rectangle {
    id: root

    readonly property real designWidth: 1600
    readonly property real designHeight: 1000
    readonly property real scaleFactor: Math.max(0.1, Math.min(width / designWidth, height / designHeight))

    width: Screen.width > 0 ? Screen.width : designWidth
    height: Screen.height > 0 ? Screen.height : designHeight

    FontLoader { id: clockFont; source: "fonts/steelfish_outline.otf" }
    FontLoader { id: mainFont;  source: "fonts/SF-Pro-Display-Bold.otf" }
    FontLoader { id: iconFont;  source: "fonts/SymbolsNerdFont-Regular.ttf" }

    property string uiFont: mainFont.status === FontLoader.Ready ? mainFont.name : "sans-serif"

    Image {
        anchors.fill: parent; source: config.background
        fillMode: Image.PreserveAspectCrop; z: 0
    }

    Clock {
        z: 1
        clockFontFamily: clockFont.name
        mainFontFamily: uiFont
        textColor: config.text_color
        scaleFactor: root.scaleFactor
    }

    Image {
        anchors.fill: parent; source: config.middleOverlay
        fillMode: Image.PreserveAspectCrop; z: 2
    }

    Image {
        source: config.foreground
        width: 1200 * root.scaleFactor
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 276 * root.scaleFactor
        z: 3
    }

    LoginForm {
        z: 4
        mainFontFamily: uiFont
        iconFontFamily: iconFont.name
        textColor: config.text_color
        scaleFactor: root.scaleFactor
    }

    StatusBar {
        z: 4
        mainFontFamily: uiFont
        iconFontFamily: iconFont.name
        scaleFactor: root.scaleFactor
    }
}
