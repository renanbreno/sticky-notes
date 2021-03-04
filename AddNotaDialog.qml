import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Dialog {
    id: addNotaDialog
    title: "Nova nota"
    x: parent.width/2 - addNotaDialog.width/2
    y: parent.height/2 - addNotaDialog.height/2

    property var noteId: ""
    property var cor
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
    }

    ColumnLayout {
        id: columnItems
        TextField {
            anchors { left: columnItems.left; right: columnItems.right }
            id: titleField
            placeholderText: "Título"
        }
        TextField {
            anchors { left: columnItems.left; right: columnItems.right }
            id: authorField
            placeholderText: "Autor"
        }
        TextField {
            anchors { left: columnItems.left; right: columnItems.right }
            id: textField
            placeholderText: "Texto"   
        }
        TextField {
            anchors { left: columnItems.left; right: columnItems.right }
            id: dateField
            text: new Date().toLocaleDateString(Qt.LocaleDate)
        }

        GridLayout {
            ButtonGroup {
                id: buttonGroup
            }
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
                    id: colorField
                    checked: false
                    text: modelData.name
                    ButtonGroup.group: buttonGroup
                    onClicked: {
                        cor = modelData.color
                    }
                }
            }
        }

        RowLayout {
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
