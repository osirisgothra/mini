#include "MainWindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent)
{
    RootUserPath = QString::fromLocal8Bit(getenv("HOME"));
    setupUi(this);
    connect(acnExit,SIGNAL(triggered()),SLOT(close()));
    connect(acnOpenUserRoot,SIGNAL(triggered()),SLOT(OnOpenRootUser));
    RePopulate();
}

void MainWindow::OnOpenRootUser(void)
{
    // change the root
    RePopulate();
}

void MainWindow::RePopulate(void)
{

}

