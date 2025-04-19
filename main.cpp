#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "database.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    database *db = new database();
    qmlRegisterSingletonInstance("Todo.Db", 1, 0, "Db", db);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Todo", "Main");



    return app.exec();
}
