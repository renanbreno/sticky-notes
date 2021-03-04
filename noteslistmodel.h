#ifndef NOTESLISTMODEL_H
#define NOTESLISTMODEL_H
#include <QCoreApplication>
#include <QAbstractListModel>
#include <QQmlEngine>
#include "nota.h"

class NotesListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        title = Qt::UserRole + 1,
        author,
        text,
        date,
        color,
    };
    Q_ENUM(Roles)

    explicit NotesListModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE void addFruta();
    static void registerTypes();

public slots:
    void insertNotes(QString title, QString author, QString text, QString date, QString color);
    void removeNotes(int index);

private:
    QList<Nota> m_notas;
};

#endif // NOTESLISTMODEL_H
