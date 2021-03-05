import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ApplicationWindow {
    width: 1024
    height: 780
    visible: true
    title: qsTr("Qt Dev.Academy")
    color: "#fafafa"

    RemoveNoteDialog {
        id: removeNoteDialog
        onAccepted: {
            dbNotes.deleteRow(note.id)
        }
    }

    AddNotaDialog {
        id: addNotaDialog
        onCancelPressed: {
            addNotaDialog.clearFields()
            addNotaDialog.close()
        }
        onOkPressed: {
            dbNotes.newRow(title, author, text, date, color)
            addNotaDialog.clearFields()
            addNotaDialog.close()
        }
    }

    AddNotaDialog {
        id: updateNoteDialog
        onCancelPressed: {
            updateNoteDialog.close()
        }
        onOkPressed: {
            dbNotes.updateRow(id, title, author, text, date, color)
            updateNoteDialog.close()
        }
    }

    NotesDatabaseModel {
        id: dbNotes
    }

    header: ToolBar {
        RowLayout {
            anchors {
                fill: parent
                rightMargin: 16
                leftMargin: 16
            }
            ToolButton {
                text: "Keep dev.academy"
            }
            Item { Layout.fillWidth: true; }
            Button {
                Material.background: Material.LightBlue
                text: "Mudar visualização"
                onPressed: {
                    myModel.setValue(myModel.key)
                }
            }
        }
    }

    ColumnLayout {
        anchors { fill: parent; margins: 16 }
        RowLayout {
            Layout.fillWidth: true
            Text {
                text: `Notas do ${myModel.name}`
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                font.pixelSize: 18
            }
            TextField {
                id: nameField
            }
            Button {
                text: "Salvar"
                enabled: nameField != ""
                onPressed: {
                    if(nameField !== "") {
                        myModel.setName(nameField.text, myModel.id)
                    }
                    nameField.clear()
                }
            }
        }

        RowLayout {
            Text {
                text: "Notas"
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            Button {
                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/adicionar.png"
                }
                onPressed: {
                    addNotaDialog.open()
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            NotesView {
                anchors.fill: parent
                model: dbNotes

                onUpdateButtonPressed: {
                    updateNoteDialog.setFields(note)
                    updateNoteDialog.open()
                }
                onRemoveButtonPressed: {
                    removeNoteDialog.note = note
                    removeNoteDialog.open()
                }
            }
        }
    }
}


