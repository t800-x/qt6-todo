import QtQuick
import QtQuick.Effects
import Todo.Db

Item {

    required property Window rootWindow
    property bool isVisible: false

    function write_Db(data) {
        Db.add_entry(data.trim())
        console.log(Db.query_db("SELECT description FROM tasks"))
        isVisible = false;
    }

    Rectangle {
        id: add_dialogue
        radius: 20
        width: rootWindow.width * (65/100)
        height: rootWindow.height * (50/100)
        z: add_dialogue_shadow.z + 1
        color: "#212121"
        visible: isVisible

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        Text {
            id: add_task_header
            text: qsTr("Add Task")
            color: "white"
            font {
                family: "inter"
                pixelSize: 20
                bold: true
            }

            anchors {
                top: parent.top
                left: parent.left
                topMargin: 25
                leftMargin: 30
            }
        }

        Rectangle {
            id: input_field
            color: "transparent"
            border.color: "white"
            border.width: 1
            radius: 5
            width: parent.width * (70/100)
            height: parent.height * (20/100)

            anchors {
                top: add_task_header.bottom
                left: parent.left
                topMargin: 20
                leftMargin: 30
            }

            Text {
                id: placeholder

                color: Qt.lighter(Qt.lighter(rootWindow.color))
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: "Description"

                font {
                    family: "inter"
                    pixelSize: 15
                }

                anchors {
                    fill: parent
                    leftMargin: 8
                    rightMargin: 8
                }
            }

            TextInput {
                id: add_task_input

                color: "white"
                cursorVisible: true
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.Wrap
                focus: true

                font {
                    family: "inter"
                    pixelSize: 20
                }

                anchors {
                    leftMargin: 8
                    rightMargin: 8
                }

                onTextEdited: {
                    placeholder.text= ""
                }

                onAccepted: {
                    write_Db(add_task_input.text)
                }
            }
        }

        Rectangle {
            id: add_task
            color: "#6A8DFF"
            radius: 8
            height: 35
            width: 45
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: 30
                bottomMargin: 20
            }

            Text {
                id: add_text
                color: "white"
                text: qsTr("Add")
                font {
                    family: "inter"
                    pixelSize: 15
                }
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    write_Db(add_task_input.text)
                }
            }
        }

        Rectangle {
            id: cancel_add_task
            color: Qt.lighter(rootWindow.color)
            radius: 8
            height: 35
            width: 65
            anchors {
                bottom: parent.bottom
                right: add_task.left
                rightMargin: 15
                bottomMargin: 20
            }

            Text {
                id: cancel_text
                color: "white"
                text: qsTr("Cancel")
                font {
                    family: "inter"
                    pixelSize: 15
                }
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    isVisible = false
                }
            }
        }

    }

    RectangularShadow {
        id: add_dialogue_shadow
        anchors.fill: add_dialogue
        offset.x: -10
        offset.y: -5
        radius: add_dialogue.radius
        blur: 30
        spread: 10
        color: Qt.darker(add_dialogue.color, 1.6)
        visible: add_dialogue.visible
        z: dark_overlay.z + 1
    }

    Rectangle {
        id: dark_overlay
        color: "black"
        opacity: 0.25
        z: base_z.z
        visible: add_dialogue.visible
        height: rootWindow.height * 2
        width: rootWindow.width * 2
        anchors.verticalCenter: add_dialogue.verticalCenter
        anchors.horizontalCenter: add_dialogue.horizontalCenter

    }

    Item {
        id: base_z
        z: 0
    }


}
