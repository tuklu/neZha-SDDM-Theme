import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    property string mainFontFamily: ""
    property string iconFontFamily: ""
    property color textColor: "#b3ffffff"

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 414
        spacing: 6

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Text {
                text: ""
                color: textColor
                font.pixelSize: 16
                font.family: iconFontFamily
            }
            Text {
                text: userModel.lastUser
                color: textColor
                font.pixelSize: 14
                font.family: mainFontFamily
                font.bold: true
                topPadding: -2
            }
        }

        TextField {
            id: passwordField
            width: 222
            height: 40

            focus: true
            cursorDelegate: Component { Item {} }
            echoMode: TextInput.Password

            font.family: mainFontFamily
            font.bold: true
            font.pixelSize: 13
            color: textColor
            horizontalAlignment: TextInput.AlignHCenter

            background: Rectangle {
                color: Qt.rgba(0, 0, 0, 0.2)
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                radius: 37
            }

            Text {
                anchors.centerIn: parent
                text: "Give me the password"
                color: Qt.rgba(1, 1, 1, 0.5)
                font.family: mainFontFamily
                font.bold: true
                font.pixelSize: 13
                visible: passwordField.text.length === 0
            }

            Keys.onReturnPressed: sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex)
        }
    }
}
