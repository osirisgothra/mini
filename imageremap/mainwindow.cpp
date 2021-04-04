#include "mainwindow.h"
#include <QMessageBox>
#include <QFileDialog>
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}
MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_actionHelpAbout_triggered()
{
    QMessageBox* qmb = new QMessageBox(QMessageBox::Icon::Information,"About Dialog","imageremap (nonrelease) v1.0 tiny, not even developed yet so you should not be reading this!");
    qmb->show();
    delete qmb;
}

void MainWindow::on_actionAssociateFilesToLayout_triggered()
{
    QStringList toAdd = QFileDialog::getOpenFileNames(this,tr("Associate File(s)"),QDir::currentPath(),"Images (*.png);;All Files(*)");
    if ( toAdd.count() > 0 ) {
        qsAssocPaths.append(toAdd);
    }

}
