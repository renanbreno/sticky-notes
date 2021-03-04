import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Dialog {
    id: removeNoteDialog
    property var note
    standardButtons: Dialog.Ok | Dialog.Cancel
    title: "Confirma a exclusão da nota?"
    x: parent.width/2 - addNotaDialog.width/2
    y: parent.height/2 - addNotaDialog.height/2
}
