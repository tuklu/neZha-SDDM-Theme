import QtQuick 2.15

Item {
    anchors.fill: parent

    property string clockFontFamily
    property string mainFontFamily
    property color  textColor

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
        font.family: clockFontFamily; font.pixelSize: 300
        color: textColor
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -100
    }

    Text {
        id: dateLabel
        text: Qt.formatDate(new Date(), "dddd, MMMM dd")
        font.family: mainFontFamily; font.pixelSize: 53; font.bold: true
        color: textColor
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -290
    }
}
