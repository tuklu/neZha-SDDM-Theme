import QtQuick 2.15

Row {
    property string mainFontFamily
    property string iconFontFamily
    property int    sz: 12

    anchors.top: parent.top; anchors.right: parent.right
    anchors.topMargin: 6; anchors.rightMargin: 11
    spacing: 13

    Row {
        spacing: 5
        Text {
            text: (keyboard && keyboard.layouts && keyboard.layouts[keyboard.currentLayout])
                  ? keyboard.layouts[keyboard.currentLayout].shortName : "U.S"
            font.family: mainFontFamily; font.pixelSize: 14
            color: Qt.rgba(1, 1, 1, 0.8); topPadding: -4
        }
        Text {
            text: ""; font.family: iconFontFamily; font.pixelSize: sz
            color: Qt.rgba(1, 1, 1, 0.8)
        }
    }

    Text {
        id: wifiIcon
        property string currentIcon: "󰤯"

        Timer {
            interval: 2000; running: true; repeat: true; triggeredOnStart: true
            onTriggered: {
                try {
                    var xhr = new XMLHttpRequest()
                    xhr.open("GET", "file:///proc/net/wireless", false)
                    xhr.send()
                    var lines = xhr.responseText.split('\n')
                    if (lines.length > 2 && lines[2].trim()) {
                        var rssi = parseInt(lines[2].trim().split(/\s+/)[3].replace('.', ''))
                        if      (rssi >= -60) wifiIcon.currentIcon = "󰤨"
                        else if (rssi >= -70) wifiIcon.currentIcon = "󰤥"
                        else if (rssi >= -80) wifiIcon.currentIcon = "󰤢"
                        else if (rssi >= -89) wifiIcon.currentIcon = "󰤟"
                        else                  wifiIcon.currentIcon = "󰤯"
                    } else {
                        wifiIcon.currentIcon = "󰤯"
                    }
                } catch(e) { wifiIcon.currentIcon = "󰤮" }
            }
        }

        text: currentIcon; font.family: iconFontFamily; font.pixelSize: sz
        color: Qt.rgba(1, 1, 1, 0.8)
    }

    Text {
        text: ""; font.family: iconFontFamily; font.pixelSize: sz
        color: Qt.rgba(1, 1, 1, 0.8)
    }

    Row {
        id: batteryRow
        spacing: 6

        property int    capacity: 100
        property string status:   "Unknown"
        property string batPath:  ""

        Timer {
            interval: 2000; running: true; repeat: true; triggeredOnStart: true
            onTriggered: {
                if (!batteryRow.batPath) {
                    var paths = ["BAT0", "BAT1", "macsmc-battery"]
                    for (var i = 0; i < paths.length; i++) {
                        var x = new XMLHttpRequest()
                        x.open("GET", "file:///sys/class/power_supply/" + paths[i] + "/type", false)
                        x.send()
                        if (x.responseText.trim() === "Battery") { batteryRow.batPath = paths[i]; break }
                    }
                }
                if (batteryRow.batPath) {
                    var xc = new XMLHttpRequest()
                    xc.open("GET", "file:///sys/class/power_supply/" + batteryRow.batPath + "/capacity", false)
                    xc.send()
                    if (xc.responseText) batteryRow.capacity = parseInt(xc.responseText)

                    var xs = new XMLHttpRequest()
                    xs.open("GET", "file:///sys/class/power_supply/" + batteryRow.batPath + "/status", false)
                    xs.send()
                    if (xs.responseText) batteryRow.status = xs.responseText.trim()
                }
            }
        }

        Text {
            text: batteryRow.capacity + "%"
            font.family: mainFontFamily; font.pixelSize: sz
            color: Qt.rgba(1, 1, 1, 0.8)
        }
        Text {
            font.family: iconFontFamily; font.pixelSize: sz
            color: Qt.rgba(1, 1, 1, 0.8)
            text: {
                var c = batteryRow.capacity
                if (batteryRow.status === "Charging") {
                    if (c >= 90) return "󰂅"; if (c >= 80) return "󰂋"; if (c >= 70) return "󰂊"
                    if (c >= 60) return "󰢞"; if (c >= 50) return "󰂉"; if (c >= 40) return "󰢝"
                    if (c >= 30) return "󰂈"; if (c >= 20) return "󰂇"; if (c >= 10) return "󰂆"
                    return "󰢜"
                }
                if (batteryRow.status === "Full") return "󰂅"
                if (c >= 90) return "󰁹"; if (c >= 80) return "󰂂"; if (c >= 70) return "󰂁"
                if (c >= 60) return "󰂀"; if (c >= 50) return "󰁿"; if (c >= 40) return "󰁾"
                if (c >= 30) return "󰁽"; if (c >= 20) return "󰁼"; if (c >= 10) return "󰁻"
                return "󰁺"
            }
        }
    }
}
