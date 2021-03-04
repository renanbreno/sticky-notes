#include "noteslistmodel.h"
#include <QAbstractListModel>
#include <QCoreApplication>

NotesListModel::NotesListModel(QObject *parent)
{

}

int NotesListModel::rowCount(const QModelIndex &parent) const
{
    return m_notas.size();
}

QVariant NotesListModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) {
        return QVariant();
    }
    switch(role) {
    case title:
        return m_notas.at(index.row()).title;
        break;
    case author:
        return m_notas.at(index.row()).author;
        break;
    case text:
        return m_notas.at(index.row()).text;
        break;
    case date:
        return m_notas.at(index.row()).date;
        break;
    case color:
        return m_notas.at(index.row()).color;
        break;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> NotesListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[title] = "name";
    roles[author] = "price";
    roles[text] = "calories";
    roles[date] = "date";
    roles[color] = "color";
    return roles;
}

void NotesListModel::addNote()
{
    beginResetModel();
    m_notas.clear();
    m_notas.append(Nota("Abacaxi", "5.50", "100", "03/03/2021", "#DC143C"));
    m_notas.append(Nota("Morango", "12", "34", "03/03/2021", "#DAA520"));
    m_notas.append(Nota("Kiwi", "7.55", "163", "03/03/2021", "#98FB98"));
    m_notas.append(Nota("Tangerina", "3", "123", "03/03/2021", "#008080"));
    endResetModel();
}

void NotesListModel::insertNotes(QString title, QString author, QString text, QString date, QString color)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_notas.append(Nota(title, author, text, date, color));
    endInsertRows();
}

void NotesListModel::removeNotes(int index)
{
    beginRemoveRows(QModelIndex(), index, index);
    m_notas.removeAt(index);
    endRemoveRows();
}

void registerListModelTypes() {
    qmlRegisterType<NotesListModel>("Models", 1, 0, "NotesListModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerListModelTypes)
