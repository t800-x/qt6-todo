#include "database.h"
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariantList>
#include <QVariantMap>

database::database(QObject *parent)
{

}

bool database::create_table(QString query)
{
    QSqlQuery query_run;
    if(!query_run.exec(query))
    {
        qDebug() << "Failed to create table:" << query_run.lastError().text();
        return false;
    }

    qDebug() << "Table created or already exists";
    return true;
}



bool database::initDB()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("tasks.db");

    if(!db.open())
    {
        qDebug() << "Error opening databse: " << db.lastError().text();
        return false;
    }

    QString create = R"(
        CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT NOT NULL
        )
    )";

    if(!database::create_table(create))
    {
        return false;
    }

    query_db("SELECT * FROM tasks");
    qDebug() << "DB initiated";



    return true;
}

QVariantList database::query_db(QString query)
{
    QSqlQuery query_run(query);
    while(query_run.next())
    {
        task["id"] = query_run.value("id");
        task["description"] = query_run.value("description");
        task_list.append(task);
    }

    return task_list;
}

bool database::add_entry(QString description)
{
    QSqlQuery query_run;
    query_run.prepare("INSERT INTO tasks (description) VALUES (:description)");
    query_run.bindValue(":description", description);

    if(!query_run.exec())
    {
        qDebug() << "Failed to add database entry: " << query_run.lastError().text();
        qDebug() << "Data: " + description;
        return false;
    }

    qDebug() << "Added entry: " + description;

    emit task_list_changed();

    return true;

}

QVariantList database::get_task_list()
{
    return task_list;
}
