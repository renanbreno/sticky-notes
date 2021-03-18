import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3

Dialog {
    id: removeNoteDialog
    property var note
    standardButtons: Dialog.Ok | Dialog.Cancel
    Text {
        id: name
        text: qsTr("Confirma a exclusão da nota?")
        color: myModel.viewTheme == "darkTheme" ? "white" : "black"
        font.pixelSize: 26
    }
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    Material.background: myModel.viewTheme == "darkTheme" ? "#050505" : "#fafafa"

}
