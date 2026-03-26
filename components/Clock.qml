import QtQuick 2.15

Item {
    anchors.fill: parent

    property string clockFontFamily: ""
    property string mainFontFamily: ""
    property color textColor: "#b3ffffff"

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            timeLabel.text = Qt.formatTime(new Date(), "hh:mm")
            dateLabel.text = Qt.formatDate(new Date(), "dddd, MMMM dd")
        }
    }

    Text {
        id: timeLabel
        text: Qt.formatTime(new Date(), "hh:mm")
        color: textColor
        font.pixelSize: 300
        font.family: clockFontFamily
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -100
    }

    Text {
        id: dateLabel
        text: Qt.formatDate(new Date(), "dddd, MMMM dd")
        color: textColor
        font.pixelSize: 53
        font.family: mainFontFamily
        font.bold: true
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -290
    }
}
