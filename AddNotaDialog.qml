import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Models 1.0

Dialog {
    id: addNotaDialog
    property var noteId: ""
    property var cor
    property var note

    width: parent.width - 100
    height: parent.height - 350
    x: parent.width/2 - addNotaDialog.width/2
    y: parent.height/2 - addNotaDialog.height/2

    signal cancelPressed()
    signal okPressed(string id, string title, string author, string text, string date, string color)

    function clearFields() {
        titleField.clear()
        authorField.clear()
        textField.clear()
    }

    function setFields(note) {
        noteId = note.id
        titleField.text = note.title
        authorField.text = note.author
        textField.text = note.text
        dateField.text = note.date
        cor = note.color
    }

    background: Rectangle {
        color: cor
        border.width: 2
        radius: 6
        ColumnLayout {
            anchors {
                left: parent.left
                right: parent.right
                margins: 12
            }

            id: columnItems
            TextField {
                id: titleField
                Layout.fillWidth: true
                placeholderText: "Título"
            }
            TextArea {
                id: authorField
                Layout.fillWidth: true
                placeholderText: "Autor"
            }
            TextArea {
                id: textField
                Layout.fillWidth: true
                background: Rectangle { color: "black"; opacity: 0.2 }
                placeholderText: "Texto"
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
            }
            TextField {
                id: dateField
                Layout.fillWidth: true
                text: new Date().toLocaleDateString(Qt.LocaleDate)
            }

            GridLayout {
                Layout.alignment: Qt.AlignCenter
                ButtonGroup { id: buttonGroup }
                columns: 3
                Repeater {
                    model: [
                        { name: "Azul", color: "#ABDEE6" },
                        { name: "Roxo", color: "#CBAACB" },
                        { name: "Amarelo", color: "#FFFFB5" },
                        { name: "Rosa", color: "#FFCCB6" },
                        { name: "Rosa claro", color: "#F3B0C3" },
                        { name: "Azul Claro", color: "#C6DBDA" },
                    ]

                    RadioButton {
                        background: Rectangle {
                            id: rec
                            height: 32
                            width: height
                            radius: height
                            color: modelData.color
                            border.width: 2
                        }

                        indicator: Rectangle {
                            id: recInd
                            height: 12
                            width: height
                            radius: height
                            color: parent.checked ? "black" : modelData.color
                            anchors.centerIn: rec
                        }

                        id: colorField
                        checked: modelData.color == cor
                        ButtonGroup.group: buttonGroup
                        onClicked: {
                            cor = modelData.color
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter
                spacing: 6
                Button {
                    text: "Cancelar"
                    flat: true
                    Material.foreground: "#C62828"
                    onPressed: {
                        cancelPressed()
                    }
                }
                Button {
                    x: 91
                    text: "Salvar"
                    flat: true
                    Material.foreground: "#146d99"
                    enabled: (!titleField.text == ""
                              && !authorField.text == ""
                              && !textField.text == ""
                              && !dateField.text == ""
                              && cor)

                    onPressed: {
                        okPressed(noteId, titleField.text,
                                  authorField.text,
                                  textField.text,
                                  dateField.text,
                                  cor)
                    }
                }
            }
        }
    }
}
