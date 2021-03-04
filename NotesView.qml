import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Flickable {
    signal addButtonPressed(var note)
    signal removeButtonPressed(var note)
    signal updateButtonPressed(var note)
    property alias model: repeater.model

    clip: true
    contentHeight: column.implicitHeight + 32
    ColumnLayout {
        anchors.fill: parent
        id: column
        GridLayout {
            rowSpacing: 16
            columnSpacing: 16
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: parent.width / 200
            Repeater {
                id: repeater
                Card {
                    height: 150
                    Layout.fillWidth: true
                    color: model.color

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            const note = { id: model.id,
                                title: model.title,
                                author: model.author,
                                text: model.text, date:
                                model.date,
                                color: model.color }

                            updateButtonPressed(note)
                        }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                font.pixelSize: 16
                                elide: Text.ElideRight
                                text: "Título: " + model.title
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                font.pixelSize: 16
                                elide: Text.ElideRight
                                text: "Autor: " + model.author
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                font.pixelSize: 16
                                elide: Text.ElideRight
                                text: "Texto: " + model.text
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Text {
                                font.pixelSize: 16
                                elide: Text.ElideRight
                                text: "Data: " + model.date
                                anchors.fill: parent
                            }
                        }
                    }
                }
            }
        }
    }
}
