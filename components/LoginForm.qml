import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    property string mainFontFamily
    property string iconFontFamily
    property color  textColor

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 414
        spacing: 6

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Text {
                text: ""; font.family: iconFontFamily; font.pixelSize: 16
                color: textColor
            }
            Text {
                text: userModel.lastUser
                font.family: mainFontFamily; font.pixelSize: 14; font.bold: true
                color: textColor; topPadding: -2
            }
        }

        TextField {
            id: passwordField
            width: 222; height: 40
            focus: true
            echoMode: TextInput.Password
            cursorDelegate: Component { Item {} }
            font.family: mainFontFamily; font.pixelSize: 13; font.bold: true
            color: textColor
            horizontalAlignment: TextInput.AlignHCenter

            background: Rectangle {
                color: Qt.rgba(0, 0, 0, 0.2); radius: 37
                border.width: 1; border.color: Qt.rgba(1, 1, 1, 0.1)
            }

            Text {
                anchors.centerIn: parent
                text: "Give me the password"
                font.family: mainFontFamily; font.pixelSize: 13; font.bold: true
                color: Qt.rgba(1, 1, 1, 0.5)
                visible: !passwordField.text.length
            }

            Keys.onReturnPressed: sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex)
        }
    }
}
