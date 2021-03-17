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

    function setFilter(text) {
        notesView.setFilter(text)
    }

    RemoveNoteDialog {
        id: removeNoteDialog
        onAccepted: {
            dbNotes.deleteRow(note.id)
        }
    }

    RemoveNoteDialog {
        id:removeNotesDialog
        onAccepted: {
            console.log(JSON.stringify(note))
            note.forEach((card) => {
                                dbNotes.deleteRow(card.id)
                                  }
                                      )
            notesView.clearSelected()
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

    header: CustomToolbar {
        id: searchNotes
        onTextFieldChanged: setFilter(text)
    }

    StackView {
        id: stack
        anchors.fill: parent
    }

    Menu {
        id: menu
        MenuItem {
            Image {
                anchors.fill: parent
                horizontalAlignment: Image.AlignRight
                fillMode: Image.PreserveAspectFit
                anchors.margins: 16
                source: myModel.viewState == "list" ? "qrc:/icons/grid.png" : "qrc:/icons/list.png"
            }
            text: myModel.viewState == "list" ? "Grade" : "Lista"
            onPressed: {
                myModel.toggleViewState()
            }
        }
        MenuItem {
            Image {
                anchors.fill: parent
                horizontalAlignment: Image.AlignRight
                fillMode: Image.PreserveAspectFit
                anchors.margins: 12
                source: "qrc:/icons/adicionar.png"
            }
            text: "Adicionar nota"
            onPressed: {
                addNotaDialog.open()
            }
        }
        MenuItem {
            text: "Modo Escuro"
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

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            NotesView {
                id: notesView
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
                onRemoveAllButtonPressed: {
                    removeNotesDialog.note = selectedCards
                    removeNotesDialog.open()
                }
            }
        }
    }
}
