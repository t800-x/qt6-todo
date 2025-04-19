import QtQuick
import Todo.Db
import QtQuick.Controls

Item {
    property Window rootWindow
    property var tets: []
    ListModel {
        id: tasks
        ListElement { description: "hello world" }
    }

    Component.onCompleted: {
        var results = Db.get_task_list()
        for (var i = 0; i < results.length; i++) {
            tasks.append({"description": results[i].description})
        }
    }


    ListView {
        id: taskList
        model: 5
        delegate: Task_item {
            required property var description
            description_text: model.description
            rWindow: rootWindow
        }
    }

    Task_item {
        rWindow: rootWindow
        description_text: "Hello World"
    }
}
