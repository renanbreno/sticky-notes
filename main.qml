import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Window {
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
        title: "Editar Nota"
        onCancelPressed: {
            updateNoteDialog.close()
        }
        onOkPressed: {
            dbNotes.updateRow(id, title, author, text, date, color)
            updateNoteDialog.close()
        }
    }

    FrutaDatabaseModel {
        id: dbNotes
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: `Notas do ${myModel.name}`
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            TextField {
                id: nameField
            }
            Button {
                text: "Salvar"
                enabled: nameField != ""
                onPressed: {
                    if(nameField != "") {
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

        NotesView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: dbNotes
            onAddButtonPressed: {
                note.quantidade = 1
                for(let i = 0; i < notas.rowCount(); i++) {
                    if(notas.get(i).id == note.id) {
                        notas.get(i).quantidade += 1
                        totalText.text = "Total: " + notas.getTotal()
                        return
                    }
                }
                notas.append(note)

                totalText.text = "Total: " + notas.getTotal()
            }
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
