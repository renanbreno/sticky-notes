#include "controller.h"
#include <QDebug>

Controller::Controller(QObject *parent)
{

}

void Controller::setModel(Model *model)
{
    m_model = model;
}

void Controller::mudarNome(QString nome)
{
    qDebug() << "Mudar Nome (controller)" << nome;
}

void Controller::setValue(Model *model) {
    m_model = model;
}

void Controller::mudarValue(QString valor) {
    qDebug() << "Mudar Value (Controller)" << valor;
}
