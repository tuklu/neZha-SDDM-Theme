import QtQuick 2.15

Row {
    property string mainFontFamily: ""
    property string iconFontFamily: ""

    readonly property int statusFontSize: 12

    anchors.top: parent.top
    anchors.right: parent.right
    anchors.topMargin: 6
    anchors.rightMargin: 11
    spacing: 13

    // Keyboard layout
    Row {
        spacing: 5

        Text {
            text: (keyboard && keyboard.layouts && keyboard.layouts[keyboard.currentLayout])
                  ? keyboard.layouts[keyboard.currentLayout].shortName : "U.S"
            color: Qt.rgba(1, 1, 1, 0.8)
            font.pixelSize: 14
            font.family: mainFontFamily
            topPadding: -4
        }
        Text {
            text: ""
            color: Qt.rgba(1, 1, 1, 0.8)
            font.pixelSize: statusFontSize
            font.family: iconFontFamily
        }
    }

    // WiFi signal
    Text {
        id: wifiIcon
        property string currentIcon: "󰤯"

        Timer {
            interval: 2000; running: true; repeat: true; triggeredOnStart: true
            onTriggered: {
                try {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "file:///proc/net/wireless", false);
                    xhr.send();
                    var lines = xhr.responseText.split('\n');

                    if (lines.length > 2 && lines[2].trim() !== "") {
                        var data = lines[2].trim().split(/\s+/);

                        if (data.length >= 4) {
                            var rssiStr = data[3].replace('.', '');
                            var rssi = parseInt(rssiStr);

                            if (rssi >= -60)      wifiIcon.currentIcon = "󰤨";
                            else if (rssi >= -70) wifiIcon.currentIcon = "󰤥";
                            else if (rssi >= -80) wifiIcon.currentIcon = "󰤢";
                            else if (rssi >= -89) wifiIcon.currentIcon = "󰤟";
                            else                  wifiIcon.currentIcon = "󰤯";
                        }
                    } else {
                        wifiIcon.currentIcon = "󰤯";
                    }
                } catch(e) {
                    wifiIcon.currentIcon = "󰤮";
                }
            }
        }

        text: currentIcon
        color: Qt.rgba(1, 1, 1, 0.8)
        font.pixelSize: statusFontSize
        font.family: iconFontFamily
    }

    // Bluetooth (static placeholder)
    Text {
        text: ""
        color: Qt.rgba(1, 1, 1, 0.8)
        font.pixelSize: statusFontSize
        font.family: iconFontFamily
    }

    // Battery
    Row {
        id: batteryRow
        spacing: 6

        property int capacity: 100
        property string status: "Unknown"
        property string batPath: ""

        Timer {
            interval: 2000; running: true; repeat: true; triggeredOnStart: true
            onTriggered: {
                if (batteryRow.batPath === "") {
                    var paths = ["BAT0", "BAT1", "macsmc-battery"];
                    for (var i = 0; i < paths.length; i++) {
                        var xhrCheck = new XMLHttpRequest();
                        xhrCheck.open("GET", "file:///sys/class/power_supply/" + paths[i] + "/type", false);
                        xhrCheck.send();
                        if (xhrCheck.responseText.trim() === "Battery") {
                            batteryRow.batPath = paths[i];
                            break;
                        }
                    }
                }

                if (batteryRow.batPath !== "") {
                    var xhrCap = new XMLHttpRequest();
                    xhrCap.open("GET", "file:///sys/class/power_supply/" + batteryRow.batPath + "/capacity", false);
                    xhrCap.send();
                    if (xhrCap.responseText) batteryRow.capacity = parseInt(xhrCap.responseText.trim());

                    var xhrStat = new XMLHttpRequest();
                    xhrStat.open("GET", "file:///sys/class/power_supply/" + batteryRow.batPath + "/status", false);
                    xhrStat.send();
                    if (xhrStat.responseText) batteryRow.status = xhrStat.responseText.trim();
                }
            }
        }

        Text {
            text: batteryRow.capacity + "%"
            color: Qt.rgba(1, 1, 1, 0.8)
            font.pixelSize: statusFontSize
            font.family: mainFontFamily
        }
        Text {
            text: {
                var cap = batteryRow.capacity;
                var charging = (batteryRow.status === "Charging");

                if (charging) {
                    if (cap >= 90) return "󰂅";
                    if (cap >= 80) return "󰂋";
                    if (cap >= 70) return "󰂊";
                    if (cap >= 60) return "󰢞";
                    if (cap >= 50) return "󰂉";
                    if (cap >= 40) return "󰢝";
                    if (cap >= 30) return "󰂈";
                    if (cap >= 20) return "󰂇";
                    if (cap >= 10) return "󰂆";
                    return "󰢜";
                } else {
                    if (batteryRow.status === "Full") return "󰂅";
                    if (cap >= 90) return "󰁹";
                    if (cap >= 80) return "󰂂";
                    if (cap >= 70) return "󰂁";
                    if (cap >= 60) return "󰂀";
                    if (cap >= 50) return "󰁿";
                    if (cap >= 40) return "󰁾";
                    if (cap >= 30) return "󰁽";
                    if (cap >= 20) return "󰁼";
                    if (cap >= 10) return "󰁻";
                    return "󰁺";
                }
            }
            color: Qt.rgba(1, 1, 1, 0.8)
            font.pixelSize: statusFontSize
            font.family: iconFontFamily
        }
    }
}
