#include "model.h"
#include <QDebug>
#include <QSqlQuery>

Model::Model(QObject *parent, Database *database) : m_database(database)
{

}

QString Model::name()
{
    if(m_name == "" || m_name.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM dev_academy");
        if(query.exec() && query.first()) {
            m_name = query.value("nome").toString();
        }
    }
    return m_name;
}

QString Model::id()
{
    if(m_id == "" || m_id.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM dev_academy");
        if(query.exec() && query.first()) {
            m_id = query.value("id").toString();
        }
    }
    return m_id;
}

void Model::setName(QString name)
{
    QString id = "dev_academy";
    if(m_name != name) {
        QSqlQuery query(m_database->database());
        query.prepare("INSERT OR REPLACE INTO dev_academy (id, nome) VALUES (:id, :name)");
        query.bindValue(":id", id);
        query.bindValue(":name", name);

        if (query.exec()) {
            m_name = name;
            emit nameChanged(m_name);
        }
    }
}

QString Model::value()
{
    if(m_value == "" || m_value.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM settings");
        if(query.exec() && query.first()) {
            m_value = query.value("value").toString();
        }
    }
    return m_value;
}

QString Model::key()
{
    if(m_key == "" || m_key.isNull()) {
        QSqlQuery query(m_database->database());
        query.prepare("SELECT * FROM settings");
        if(query.exec() && query.first()) {
            m_key = query.value("key").toString();
        }
    }
    return m_key;
}

void Model::setValue(QString value)
{
    QString key = "settings";
    if(m_value != value) {
        QSqlQuery query(m_database->database());
        query.prepare("INSERT OR REPLACE INTO settings (key, value) VALUES (:key, :value)");
        query.bindValue(":key", key);
        query.bindValue(":value", value);

        if (query.exec()) {
            m_value = value;
            emit valueChanged(m_value);
        }
    }
}
