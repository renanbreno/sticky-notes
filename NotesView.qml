import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Models 1.0
import "qrc:/componentes"

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
        model.setFilter(`title LIKE '%${text}%' or author LIKE '%${text}%' or text LIKE '%${text}%'`)
    }

    function clearSelected() {
        selectedCards = []
        root.selectedCardsChanged()
    }

    RoundButton {
        z: 1
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 6; bottomMargin: 10 }
        Image {
            source: "qrc:/icons/adicionar.png"
            fillMode: Image.PreserveAspectFit
        }
        onPressed: {
            addNotaDialog.open()
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignCenter
        spacing: 26
        Button {
            id: remove
            visible: selectedCards.length >= 1
            flat: true
            background: Rectangle {
                implicitHeight: 40
                implicitWidth: implicitHeight
                radius: implicitHeight
            }
            Image {
                id: imgRemove
                anchors.fill: parent
                source: "qrc:/icons/cancel.png"
                fillMode: Image.PreserveAspectFit
            }
            onPressed: {
                clearSelected()
            }
        }

        Text {
            text: "SELECIONADOS: " + (selectedCards.length)
            color: myModel.viewTheme == "darkTheme" ? "white" : "black"
        }

        Button {
            id: deleteCard
            visible: selectedCards.length >= 1
            flat: true
            background: Rectangle {
                implicitHeight: 40
                implicitWidth: implicitHeight
                radius: implicitHeight
                Image {
                    id: imgDelete
                    anchors.fill: parent
                    source: "qrc:/icons/remover.png"
                    fillMode: Image.PreserveAspectFit
                }
            }


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
                Layout.rightMargin: 8; Layout.leftMargin: 8

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
                        color: myModel.viewTheme == "darkTheme" ? Qt.darker(model.color, 2.8) : model.color

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
                                    color: myModel.viewTheme == "darkTheme" ? "white" : "black"
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
                                    color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                                    anchors.fill: parent
                                }
                            }

                            Item {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Text {
                                    font.pixelSize: 18
                                    elide: Text.ElideRight
                                    text: model.text
                                    color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                    anchors {
                                        fill: parent
                                        topMargin: isGrid ? 0 : 11 }
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
                            background: Rectangle {
                                visible: mousearea.containsMouse || cardCheckBox.hovered || card.checked
                                implicitWidth: 26
                                implicitHeight: implicitWidth
                                border.width: 2
                                border.color: "#888"
                                color: myModel.viewTheme == "darkTheme" ? Qt.darker(model.color, 4.0) : model.color
                                radius: implicitWidth
                            }

                            anchors {
                                top: parent.top
                                right: parent.right
                                margins: -14
                            }

                            onPressed: {
                                if (selected) {
                                    selectedCards.splice(selectedCards.indexOf(index), 1)
                                    selected = false
                                } else {
                                    selectedCards.push({index: index, id: model.id, title: model.title})
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

