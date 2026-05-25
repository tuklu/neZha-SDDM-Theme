import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    property string mainFontFamily
    property string iconFontFamily
    property color  textColor
    property real   scaleFactor: 1

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 414 * scaleFactor
        spacing: 6 * scaleFactor

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5 * scaleFactor

            Text {
                text: ""; font.family: iconFontFamily; font.pixelSize: 16 * scaleFactor
                color: textColor
            }
            Text {
                text: userModel.lastUser
                font.family: mainFontFamily; font.pixelSize: 14 * scaleFactor; font.bold: true
                color: textColor; topPadding: -2 * scaleFactor
            }
        }

        Item {
            width: 222 * scaleFactor; height: 40 * scaleFactor

            TextField {
                id: passwordField
                anchors.fill: parent
                focus: true
                echoMode: TextInput.Password
                cursorDelegate: Component { Item {} }
                font.family: mainFontFamily; font.pixelSize: 11 * scaleFactor; font.bold: true
                color: textColor
                horizontalAlignment: TextInput.AlignHCenter

                background: Rectangle {
                    color: Qt.rgba(0, 0, 0, 0.2); radius: 37 * scaleFactor
                    border.width: Math.max(1, scaleFactor); border.color: Qt.rgba(1, 1, 1, 0.1)
                }

                Keys.onReturnPressed: sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex)
            }

            Text {
                anchors.centerIn: parent
                text: "Give me the password"
                font.family: mainFontFamily; font.pixelSize: 13 * scaleFactor; font.bold: true
                color: Qt.rgba(1, 1, 1, 0.5)
                visible: !passwordField.text.length
            }
        }
    }
}
