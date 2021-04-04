#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "ui_MainWindow.h"

class MainWindow : public QMainWindow, private Ui::MainWindow
{

    Q_OBJECT

public:

    explicit MainWindow(QWidget *parent = 0);

private slots:
    void OnOpenRootUser(void);
    void RePopulate(void);

signals:

private:
    QString RootUserPath;

};

#endif // MAINWINDOW_H
