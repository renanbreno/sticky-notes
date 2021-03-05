#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include "database.h"

class Model : public QObject
{
Q_OBJECT
public:
    explicit Model(QObject *parent = nullptr, Database *database = new Database());

    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString id READ id)
    Q_PROPERTY(QString value READ value NOTIFY valueChanged)
    Q_PROPERTY(QString key READ key)
    QString name();
    QString id();
    QString value();
    QString key();
    Q_INVOKABLE void setName(QString name);
    Q_INVOKABLE void setValue(QString value);

signals:
    void nameChanged(QString name);
    void valueChanged(QString value);
private:
    QString m_name;
    QString m_id;
    QString m_value;
    QString m_key;
    Database *m_database;
};

#endif // MODEL_H
