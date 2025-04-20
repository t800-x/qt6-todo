import QtQuick
import QtQuick.Controls

Item {
    required property Window rWindow
    required property string description_text

    Rectangle {
        id: task_container
        color: Qt.lighter(rWindow.color)
        radius: 6
        height: task_item_text.font.pixelSize * 1.5
        width: rWindow.width * (95/100)

        Item {
            height: parent.height
            width: parent.width

            y: +3


            Text {
                id: task_item_text

                anchors {
                    fill: parent
                    leftMargin: 8
                }

                font {
                    family: "inter"
                    pixelSize: 18
                }

                height: font.pixelSize
                width: rWindow.width * (95/100)

                text:  description_text
                color: "white"
            }
        }

    }
    width:  task_container.width
    height: task_container.height
}
