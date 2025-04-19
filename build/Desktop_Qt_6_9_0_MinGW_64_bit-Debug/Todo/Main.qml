import QtQuick
import QtQuick.Effects
import Todo.Db

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Todo")
    id: root

    color: "#212121"

    Component.onCompleted: Db.initDB()

    Text {
        id: header
        text: "Tasks"
        color: "white"

        font{
            bold: true
            pixelSize: 40
            family: "inter"

        }


        anchors {
            top: parent.top
            left: parent.left
            topMargin: 20
            leftMargin: 30
        }

        visible: true
    }

    Rectangle {
        id: seperator
        width: parent.width * (95/100)
        height: 1
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
    }

    Dialogue {
        id: add_dialogue
        rootWindow: root
        isVisible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        // Start as invisible and slightly scaled down
        opacity: 0
        scale: 0.9

        // Animate opacity and scale smoothly
        Behavior on opacity {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad  // Smooth fade
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutBack  // Subtle "pop" effect
            }
        }

        // Update visibility with animation
        onIsVisibleChanged: {
            if (isVisible) {
                opacity = 1;  // Fade in
                scale = 1;   // Scale to normal
            } else {
                opacity = 0;  // Fade out
                scale = 0.9; // Shrink back
            }
        }

        // Optional: Disable interaction when invisible
        enabled: opacity > 0
    }

    Task_list {
        rootWindow: root
        id: listtask
        anchors {
            top: seperator.bottom
            left: parent.left
            topMargin: 20
            leftMargin: 16
            right: parent.right
        }
    }


    Rectangle {
        id: add_button
        color: "#6A8DFF"
        height: 50
        width: 50
        radius: 15

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottomMargin: 30

        MouseArea {
            id: add_button_mousearea
            anchors.fill: parent
            onClicked: {
                add_dialogue.isVisible = true
            }
        }


        Item {
            id: add_button_wrapper

            height: parent.height
            width: parent.width
            y: -2

            Text {
                id: add
                text: qsTr("+")
                color: "white"
                visible: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                font{
                    pixelSize: 40
                    family: "Roboto"
                }

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

            }
        }


        visible: true
    }



}



