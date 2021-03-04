import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ListView {
    signal addButtonPressed(var note)
    signal removeButtonPressed(var note)
    signal updateButtonPressed(var note)
    clip: true
    spacing: 8
    delegate: Card {
        width: parent.width
        height: 64
        color: model.color
        GridLayout {
            columnSpacing: 8
            columns: 6
            anchors.fill: parent
            anchors.margins: 8
            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Título"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Autor"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Texto"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Data"
                    anchors.fill: parent
                }
            }

            Button {
                Layout.rowSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/editar.png"
                }

                onPressed: {
                    const note = {
                        title: model.title,
                        text: model.text,
                        author: model.author,
                        date: model.date,
                        color: model.color,
                        index: index,
                        id: model.id
                    }
                    updateButtonPressed(note)
                }
            }

            Button {
                Layout.rowSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/remover.png"
                }

                onPressed: {
                    const note = {
                        title: model.title,
                        index: index,
                        id: model.id
                    }
                    removeButtonPressed(note)
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.title
                    anchors.fill: parent
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }
            }


            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.author
                    anchors.fill: parent
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.text
                    anchors.fill: parent
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.date
                    anchors.fill: parent
                    font.pixelSize: 14
                    elide: Text.ElideRight
                }
            }
        }
    }
}
