#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <qsqlquery.h>
#include <QVariantList>
#include <QVariantMap>

class database : public QObject
{
    Q_OBJECT


private:
    QSqlDatabase db;
    QString query;
    QVariantList task_list;
    QVariantMap task;

    bool create_table(QString query);

public:
    explicit database(QObject *parent = nullptr);

public slots:
    bool initDB();
    QVariantList query_db(QString query);
    bool add_entry(QString description);
    QVariantList get_task_list();



signals:
    void task_list_changed();
};

#endif // DATABASE_H
