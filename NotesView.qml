import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Flickable {
    id: flick
    signal addButtonPressed(var note)
    signal removeButtonPressed(var note)
    signal updateButtonPressed(var note)
    signal removeSelecteds(var checked)
    property var selectedCards: []
    property alias model: repeater.model
    property var isGrid: myModel.viewState == "grid"
    property var list: column

    clip: true
    contentHeight: column.implicitHeight + 32

    ColumnLayout {
        anchors.fill: parent
        id: column
        Text {
            text: "SELECIONADOS: " + (selectedCards.length)
        }

        RowLayout {
            Button {
                id: remove
                enabled: selectedCards.length >= 1
                text: "Remover seleção"
                onPressed: {
                    console.log("marcados", selectedCards)
                    for (let i = 0; i < selectedCards.length; i++) {
                        selectedCards.splice(i)
                        console.log("desmarcou todos", selectedCards)
                    }
                }
            }
        }

        GridLayout {
            rowSpacing: 16
            columnSpacing: 16
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: isGrid ? parent.width / 200 : 1
            Repeater {
                id: repeater
                Card {
                    id: card
                    property var checked: {
                        const cards = flick.selectedCards.filter((cardItem) => {
                                                        return cardItem == index
                                                       })
                        return cards.length > 0
                    }
                    Layout.preferredHeight: isGrid ? 150 : 48
                    Layout.fillWidth: true
                    color: model.color



                    MouseArea {
                        id: mousearea
                        hoverEnabled: true

                        anchors.fill: parent
                        onClicked: {
                            const note = {
                                id: model.id,
                                title: model.title,
                                author: model.author,
                                text: model.text, date:
                                model.date,
                                color: model.color }

                            updateButtonPressed(note)
                        }
                    }

                    GridLayout {
                        id: cardGrid
                        anchors.fill: parent

                        anchors.margins: 8
                        columns: !isGrid ? 4 : 1
                        Item {
                            Layout.preferredHeight: titleText.implicitHeight
                            Layout.fillWidth: true
                            Text {
                                id: titleText
                                font { pixelSize: 20; weight: Font.bold }
                                elide: Text.ElideRight
                                text: model.title
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.preferredHeight: authorText.implicitHeight
                            Layout.fillWidth: true
                            Text {
                                id: authorText
                                font.pixelSize: 18
                                elide: Text.ElideRight
                                text: model.author
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            Text {
                                font.pixelSize: 14
                                elide: Text.ElideRight
                                text: model.text
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                anchors.fill: parent
                            }
                        }

                        Item {
                            Layout.preferredHeight: dateText.implicitHeight
                            Layout.fillWidth: true
                            Text {
                                id: dateText
                                color: "#898989"
                                horizontalAlignment: Text.AlignRight
                                font.pixelSize: 12
                                elide: Text.ElideRight
                                text: model.date
                                anchors.fill: parent
                            }
                        }
                    }

                    CheckBox {
                        id: buttonCard
                        visible: mousearea.containsMouse || buttonCard.hovered || card.checked
                        anchors {
                            top: parent.top
                            right: parent.right
                        }
                        onPressed: {
                            if (checked) {
                                selectedCards.splice(selectedCards.indexOf(index), 1)
                                print("desmarcou")
                                print(selectedCards)
                            } else {
                                selectedCards.push(index)
                                print("marcou")
                                print(selectedCards)
                            }
                                selectedCardsChanged()
                        }
                    }
                }
            }
        }
    }
}
