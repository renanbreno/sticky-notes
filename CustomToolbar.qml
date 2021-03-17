import QtQuick 2.9
import QtQml 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ToolBar {
    signal textFieldChanged(string text)

    Timer {
        id: timer
        interval: 500
        repeat: false
        triggeredOnStart: false
        onTriggered: textFieldChanged(search.text)
    }

    RowLayout {
        anchors {
            fill: parent
            rightMargin: 16
            leftMargin: 16
        }
        ToolButton {
            text: ' ⋮ '
            font.pixelSize: 26
            onClicked: {
                menu.open()
            }
        }

        Item { Layout.fillWidth: true; }

        TextField {
            id: search
            placeholderText: qsTr("Buscar uma nota")
            onTextChanged: { timer.stop(); timer.start() }
        }

        Item { Layout.fillWidth: true; }
        Label {
            text: "Keep dev.academy"
        }
    }
}
