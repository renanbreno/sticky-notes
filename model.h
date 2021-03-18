#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include "database.h"

class Model : public QObject
{
Q_OBJECT
public:
    explicit Model(QObject *parent = nullptr, Database *database = new Database());

    Q_PROPERTY(QString name READ name NOTIFY nameChanged);
    Q_PROPERTY(QString id READ id);
    Q_PROPERTY(QString viewState READ viewState NOTIFY viewStateChanged);
    Q_PROPERTY(QString viewTheme READ viewTheme NOTIFY viewThemeChanged);
    QString name();
    QString id();
    QString viewState();
    QString viewTheme();
    Q_INVOKABLE void setName(QString name);
    Q_INVOKABLE void toggleViewState();
    Q_INVOKABLE void toggleViewTheme();

signals:
    void nameChanged(QString name);
    void emailChanged(QString email);
    void senhaChanged(QString senha);
    void viewStateChanged();
    void viewThemeChanged();
private:
    bool setValue(QString key, QString value);
    QString getValue(QString key, QString defaultValue = "");
    QString m_name;
    QString m_id;
    QString m_viewState;
    QString m_viewTheme;
    Database *m_database;
};

#endif // MODEL_H
