import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0
import "components"

Rectangle {
    id: root
    width: 1600; height: 1000

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
    }

    Image {
        anchors.fill: parent; source: config.middleOverlay
        fillMode: Image.PreserveAspectCrop; z: 2
    }

    Image {
        source: config.foreground; width: 1200
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 276
        z: 3
    }

    LoginForm {
        z: 4
        mainFontFamily: uiFont
        iconFontFamily: iconFont.name
        textColor: config.text_color
    }

    StatusBar {
        z: 4
        mainFontFamily: uiFont
        iconFontFamily: iconFont.name
    }
}
