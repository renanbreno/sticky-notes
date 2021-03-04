#include "notesdatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QUuid>

NotesDatabaseModel::NotesDatabaseModel(QObject *parent, Database *database) : QSqlTableModel(parent, database->database())
{
    setTable("notes");
    this->configureRoles();
    this->select();
    this->setEditStrategy(QSqlTableModel::OnRowChange);
}

void NotesDatabaseModel::configureRoles()
{
    registerRoleColumn(Id, "id");
    registerRoleColumn(Name, "title");
    registerRoleColumn(Price, "author");
    registerRoleColumn(Calories, "text");
    registerRoleColumn(Date, "date");
    registerRoleColumn(Color, "color");
}

QHash<int, QByteArray> NotesDatabaseModel::roleNames() const
{
    return m_roleColumns;
}

void NotesDatabaseModel::registerRoleColumn(int role, QByteArray columnName)
{
    m_roleColumns.insert(role, columnName);
}

QVariant NotesDatabaseModel::data(const QModelIndex &index, int role) const
{
    if(m_roleColumns.contains(role)) {
        int column = fieldIndex(m_roleColumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void NotesDatabaseModel::newRow(QString title, QString author, QString text, QString date, QString color)
{
    QString id = QUuid().createUuid().toString().replace("{", "").replace("}", "");
    QSqlQuery insertQuery(QSqlTableModel::database());
    insertQuery.prepare(
                "insert into notes(id, title, author, text, date, color) "
                "VALUES (:id, :title, :author, :text, :date, :color) "
    );
    insertQuery.bindValue(":id", id);
    insertQuery.bindValue(":title", title);
    insertQuery.bindValue(":author", author);
    insertQuery.bindValue(":text", text);
    insertQuery.bindValue(":date", date);
    insertQuery.bindValue(":color", color);
    insertQuery.exec();
    select();
}

void NotesDatabaseModel::updateRow(QString id, QString title, QString author, QString text, QString date, QString color)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare(
                "update notes set title = :title, author = :author, text = :text, date = :date, color = :color "
                "where id = :id"
    );
    updateQuery.bindValue(":id", id);
    updateQuery.bindValue(":title", title);
    updateQuery.bindValue(":author", author);
    updateQuery.bindValue(":text", text);
    updateQuery.bindValue(":date", date);
    updateQuery.bindValue(":color", color);
    updateQuery.exec();
    select();
}

void NotesDatabaseModel::deleteRow(QString id)
{
    QSqlQuery deleteQuery(QSqlTableModel::database());
    deleteQuery.prepare("delete from notes where id = :id");
    deleteQuery.bindValue(":id", id);
    deleteQuery.exec();
    select();
}

void registerTypes() {
    qmlRegisterType<NotesDatabaseModel>("Models", 1, 0, "FrutaDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes)
