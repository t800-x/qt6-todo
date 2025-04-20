import QtQuick
import QtQuick.Controls

Item {
    property Window rootWindow
    width:  rootWindow.width
    height: rootWindow.height

    // static example still renders:
    Task_item {
        description_text: "Hello World"
        rWindow: rootWindow
    }

    // Your data
    property var myTasks: ["Alpha", "Beta", "Gamma"]

    // <-- THIS must exist so `column` is defined!
    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.implicitHeight
        clip: true

        Column {
            id: column
            width: flick.width
            spacing: 8
        }
    }

    Component.onCompleted: {
        // load Task_item.qml once
        let comp = Qt.createComponent("Task_item.qml")
        if (comp.status === Component.Error) {
            console.error("load failed:", comp.errorString())
            return
        }
        function instantiateAll() {
            for (let i = 0; i < myTasks.length; ++i) {
                let item = comp.createObject(column, {
                    rWindow: rootWindow,
                    description_text: myTasks[i]
                })
                if (!item)
                    console.error("create failed:", comp.errorString())
            }
        }
        if (comp.status === Component.Loading) {
            comp.statusChanged.connect(() => {
                if (comp.status === Component.Ready)
                    instantiateAll()
            })
        } else {
            instantiateAll()
        }
    }
}
