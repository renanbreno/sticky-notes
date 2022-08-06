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

    width: Math.min(450, Math.max(parent.width - 16, 150))
    height: parent.height - 300

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
        id: backgroundRectangle
        color: myModel.viewTheme == "darkTheme" ? Qt.darker(cor, 2.8) : cor
        border.color: "#222222"
        border.width: 2
        radius: 6
        ColumnLayout {
            anchors.fill: parent
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                contentHeight: columnItems.implicitHeight + 32
                ColumnLayout {
                    id: columnItems
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 12
                    }
                    GridLayout {
                        Layout.alignment: Qt.AlignCenter
                        ButtonGroup { id: buttonGroup }
                        columns: 10

                        Repeater {
                            model: [
                                { name: "Azul", color: "#ABDEE6" },
                                { name: "Roxo", color: "#CBAACB" },
                                { name: "Amarelo", color: "#FFFFB5" },
                                { name: "Rosa", color: "#FFCCB6" },
                                { name: "Rosa claro", color: "#F3B0C3" },
                                { name: "Azul Claro", color: "#C6DBDA" },
                                { name: "Branco", color: "#fafafa" },
                            ]

                            RadioButton {
                                background: Rectangle {
                                    id: rec
                                    height: 32
                                    width: height
                                    radius: height
                                    color: myModel.viewTheme == "darkTheme" ? Qt.darker(modelData.color, 2.8) : modelData.color
                                    border.width: 2
                                }

                                indicator: Rectangle {
                                    id: recInd
                                    height: 12
                                    width: height
                                    radius: height
                                    color: parent.checked ? "black" : rec.color
                                    anchors.centerIn: rec
                                }

                                checked: modelData.color == cor
                                ButtonGroup.group: buttonGroup
                                onClicked: {
                                    cor = modelData.color
                                }
                            }
                        }
                    }
                    TextField {
                        id: titleField
                        Layout.fillWidth: true
                        placeholderText: "Título"
                        color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                    }
                    TextField {
                        id: authorField
                        Layout.fillWidth: true
                        placeholderText: "Autor"
                        color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                    }
                    TextField {
                        id: dateField
                        Layout.fillWidth: true
                        text: new Date().toLocaleDateString(Qt.LocaleDate)
                        color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                    }
                    TextArea {
                        id: textField
                        Layout.fillWidth: true
                        background: Rectangle { color: "black"; opacity: 0.1; radius: 2 }
                        placeholderText: "Texto"
                        color: myModel.viewTheme == "darkTheme" ? "white" : "black"
                        wrapMode: "WrapAtWordBoundaryOrAnywhere"
                    }
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignCenter
                spacing: 16
                Button {
                    text: "Cancelar"
                    Material.background: "#fafafa"
                    Material.foreground: "#050505"
                    onPressed: {
                        cancelPressed()
                    }
                }
                Button {
                    x: 91
                    text: "Salvar"
                    Material.background: Material.Blue
                    Material.foreground: "#050505"
                    enabled: (!titleField.text == ""
                              && !authorField.text == ""
                              && !textField.text == ""
                              && !dateField.text == "")

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
