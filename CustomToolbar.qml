import QtQuick 2.9
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

import Models 1.0

ToolBar {
    signal textFieldChanged(string text)
    Material.primary: myModel.viewTheme == "darkTheme" ? "#222222" : Material.BlueGrey
    Timer {
        id: timer
        interval: 500
        repeat: false
        triggeredOnStart: false
        onTriggered: textFieldChanged(search.text)
    }

    RowLayout {
        id: toolbar
        anchors {
            fill: parent
            rightMargin: 12; leftMargin: 12
        }

        ToolButton {
            text: ' ⋮ '
            Material.foreground: "white"
            font.pixelSize: 26
            onClicked: {
                menu.open()
            }
        }

        TextField {
            id: search
            placeholderText: qsTr("Buscar uma nota")
            placeholderTextColor: "white"
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
            onTextChanged: { timer.stop(); timer.start() }
            Image {
                anchors {
                    right: parent.right; bottom: parent.bottom
                    bottomMargin: 15
                }
                fillMode: Image.PreserveAspectFit
                smooth: true; visible: search.text
                source: "qrc:/icons/cross.png"

                MouseArea {
                    id: clear
                    anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                    height: search.height; width: search.height
                    onClicked: {
                        search.text = ""
                    }
                }
            }
        }
        Label {
            text: "keep.dev"
            color: "white"
            font.pixelSize: 20
            visible: root.width < root.height ? false : true
        }
    }
}

