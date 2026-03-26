import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root

    // Current target resolution — adjust if your display differs
    width: 1920   // px
    height: 1080  // px

    // ── Fonts ────────────────────────────────────────────────────────────────
    FontLoader { id: clockFont;    source: "fonts/steelfish_outline.otf" }
    FontLoader { id: mainFont;     source: "fonts/SF-Pro-Display-Bold.otf" }   // see README — not bundled
    FontLoader { id: fallbackFont; source: "fonts/Inter-Bold.otf" }            // bundled fallback
    FontLoader { id: iconFont;     source: "fonts/SymbolsNerdFont-Regular.ttf" }

    // SF Pro → Inter → system sans-serif
    readonly property string uiFont: mainFont.status     === FontLoader.Ready ? mainFont.name
                                   : fallbackFont.status === FontLoader.Ready ? fallbackFont.name
                                   : "sans-serif"

    // ── Layers ───────────────────────────────────────────────────────────────

    // z:0  Background
    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        z: 0
    }

    // z:1  Clock + date
    Clock {
        z: 1
        clockFontFamily: clockFont.name
        mainFontFamily: uiFont
        textColor: config.text_color
    }

    // z:2  Middle overlay
    Image {
        anchors.fill: parent
        source: config.middleOverlay
        fillMode: Image.PreserveAspectCrop
        z: 2
    }

    // z:3  Foreground decoration
    Image {
        source: config.foreground
        width: 1200
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 276
        z: 3
    }

    // z:4  Login form + status bar
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
