import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ColumnLayout {
    id: root
    signal addButtonPressed(var note)
    signal removeButtonPressed(var note)
    signal removeAllButtonPressed(var selectedCards)
    signal updateButtonPressed(var note)
    property var selectedCards: []
    property alias model: repeater.model
    property var isGrid: myModel.viewState == "grid"
    property var list: column

    Layout.fillWidth: true
    Layout.fillHeight: true

    function setFilter(text) {
        if (text === "") {
            model.setFilter(text)
        }
        model.setFilter(`title LIKE '%${text}%'`)
    }

    function clearSelected() {
        selectedCards = []
        root.selectedCardsChanged()
    }

    Text {
        text: "SELECIONADOS: " + (selectedCards.length)
    }

    RowLayout {
        Button {
            id: remove
            enabled: selectedCards.length >= 1
            text: "Remover seleção"
            onPressed: {
                clearSelected()
            }
        }
        Button {
            id: deleteCard
            enabled: selectedCards.length >= 1
            text: "Remover cards"
            onPressed: {
                root.removeAllButtonPressed(selectedCards)
            }
        }
    }
    Flickable {
        id: flick
        clip: true
        contentHeight: column.implicitHeight + 32
        Layout.fillWidth: true
        Layout.fillHeight: true

        ColumnLayout {
            anchors.fill: parent
            id: column

            GridLayout {
                id: grid
                rowSpacing: 16
                columnSpacing: 16
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: isGrid ? parent.width / 200 : 1
                Layout.rightMargin: 16; Layout.leftMargin: 16

                Repeater {
                    id: repeater
                    Card {
                        id: card
                        property alias checkBox: cardCheckBox
                        property var checked: {
                            const cards = root.selectedCards.filter((cardItem) => {
                                                                         return cardItem.index == index
                                                                     })
                            let result = cards.length > 0
                            if (!result) {
                                checkBox.selected = false
                            }
                            return result
                        }
                        Layout.preferredHeight: isGrid ? 200 : 60
                        Layout.maximumWidth: root.width / grid.columns
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

                        RoundButton {
                            id: cardCheckBox
                            property var selected: false

                            visible: mousearea.containsMouse || cardCheckBox.hovered || card.checked
                            Material.background: selected ? "red" : "black"
                            anchors {
                                top: parent.top
                                right: parent.right
                                margins: -20
                            }
                            onPressed: {
                                if (selected) {
                                    selectedCards.splice(selectedCards.indexOf(index), 1)
                                    print("desmarcou")
                                    print(selectedCards)
                                    selected = false
                                } else {
                                    selectedCards.push({index: index, id: model.id, title: model.title})
                                    print("marcou")
                                    print(selectedCards)
                                    selected = true
                                }
                                root.selectedCardsChanged()
                            }
                        }
                    }
                }
            }
        }
    }
}

