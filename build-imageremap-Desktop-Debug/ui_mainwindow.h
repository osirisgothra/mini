/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenu>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QSplitter>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTreeWidget>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QAction *action_Open_Layout;
    QAction *action_Save_Layout;
    QAction *action;
    QAction *actionExit;
    QAction *actionCommit;
    QAction *actionAbout;
    QAction *actionAssociateFilesToLayout;
    QAction *actionDisassociateFromLayout;
    QAction *actionSetupRemapPalette;
    QAction *actionClearRemapPalette;
    QAction *actionPurgePendingActions;
    QAction *actionContents;
    QAction *actionHelpAbout;
    QWidget *centralwidget;
    QVBoxLayout *verticalLayout;
    QSplitter *splitter;
    QListWidget *listWidget;
    QTreeWidget *treeView;
    QMenuBar *menubar;
    QMenu *menu_File;
    QMenu *menu_Map;
    QMenu *menu_Help;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(830, 591);
        action_Open_Layout = new QAction(MainWindow);
        action_Open_Layout->setObjectName(QString::fromUtf8("action_Open_Layout"));
        action_Save_Layout = new QAction(MainWindow);
        action_Save_Layout->setObjectName(QString::fromUtf8("action_Save_Layout"));
        action = new QAction(MainWindow);
        action->setObjectName(QString::fromUtf8("action"));
        actionExit = new QAction(MainWindow);
        actionExit->setObjectName(QString::fromUtf8("actionExit"));
        actionCommit = new QAction(MainWindow);
        actionCommit->setObjectName(QString::fromUtf8("actionCommit"));
        actionAbout = new QAction(MainWindow);
        actionAbout->setObjectName(QString::fromUtf8("actionAbout"));
        actionAssociateFilesToLayout = new QAction(MainWindow);
        actionAssociateFilesToLayout->setObjectName(QString::fromUtf8("actionAssociateFilesToLayout"));
        actionDisassociateFromLayout = new QAction(MainWindow);
        actionDisassociateFromLayout->setObjectName(QString::fromUtf8("actionDisassociateFromLayout"));
        actionSetupRemapPalette = new QAction(MainWindow);
        actionSetupRemapPalette->setObjectName(QString::fromUtf8("actionSetupRemapPalette"));
        actionClearRemapPalette = new QAction(MainWindow);
        actionClearRemapPalette->setObjectName(QString::fromUtf8("actionClearRemapPalette"));
        actionPurgePendingActions = new QAction(MainWindow);
        actionPurgePendingActions->setObjectName(QString::fromUtf8("actionPurgePendingActions"));
        actionContents = new QAction(MainWindow);
        actionContents->setObjectName(QString::fromUtf8("actionContents"));
        actionHelpAbout = new QAction(MainWindow);
        actionHelpAbout->setObjectName(QString::fromUtf8("actionHelpAbout"));
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        verticalLayout = new QVBoxLayout(centralwidget);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        splitter = new QSplitter(centralwidget);
        splitter->setObjectName(QString::fromUtf8("splitter"));
        splitter->setOrientation(Qt::Horizontal);
        listWidget = new QListWidget(splitter);
        listWidget->setObjectName(QString::fromUtf8("listWidget"));
        splitter->addWidget(listWidget);
        treeView = new QTreeWidget(splitter);
        QTreeWidgetItem *__qtreewidgetitem = new QTreeWidgetItem();
        __qtreewidgetitem->setText(0, QString::fromUtf8("1"));
        treeView->setHeaderItem(__qtreewidgetitem);
        treeView->setObjectName(QString::fromUtf8("treeView"));
        splitter->addWidget(treeView);

        verticalLayout->addWidget(splitter);

        MainWindow->setCentralWidget(centralwidget);
        menubar = new QMenuBar(MainWindow);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 830, 17));
        menu_File = new QMenu(menubar);
        menu_File->setObjectName(QString::fromUtf8("menu_File"));
        menu_Map = new QMenu(menubar);
        menu_Map->setObjectName(QString::fromUtf8("menu_Map"));
        menu_Help = new QMenu(menubar);
        menu_Help->setObjectName(QString::fromUtf8("menu_Help"));
        MainWindow->setMenuBar(menubar);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName(QString::fromUtf8("statusbar"));
        MainWindow->setStatusBar(statusbar);

        menubar->addAction(menu_File->menuAction());
        menubar->addAction(menu_Map->menuAction());
        menubar->addAction(menu_Help->menuAction());
        menu_File->addAction(action_Open_Layout);
        menu_File->addAction(action_Save_Layout);
        menu_File->addSeparator();
        menu_File->addAction(actionExit);
        menu_Map->addAction(actionCommit);
        menu_Map->addSeparator();
        menu_Map->addAction(actionAssociateFilesToLayout);
        menu_Map->addAction(actionDisassociateFromLayout);
        menu_Map->addSeparator();
        menu_Map->addAction(actionSetupRemapPalette);
        menu_Map->addAction(actionClearRemapPalette);
        menu_Map->addAction(actionPurgePendingActions);
        menu_Help->addAction(actionContents);
        menu_Help->addSeparator();
        menu_Help->addAction(actionHelpAbout);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", nullptr));
        action_Open_Layout->setText(QApplication::translate("MainWindow", "&Open Layout", nullptr));
        action_Save_Layout->setText(QApplication::translate("MainWindow", "&Save Layout", nullptr));
        action->setText(QApplication::translate("MainWindow", "-", nullptr));
        actionExit->setText(QApplication::translate("MainWindow", "E&xit", nullptr));
        actionCommit->setText(QApplication::translate("MainWindow", "Run/Commit", nullptr));
        actionAbout->setText(QApplication::translate("MainWindow", "&About imageremap", nullptr));
        actionAssociateFilesToLayout->setText(QApplication::translate("MainWindow", "&Associate Set of Files with Layout...", nullptr));
        actionDisassociateFromLayout->setText(QApplication::translate("MainWindow", "&Disassociate Selected From Layout...", nullptr));
        actionSetupRemapPalette->setText(QApplication::translate("MainWindow", "Setup Remap Palette...", nullptr));
        actionClearRemapPalette->setText(QApplication::translate("MainWindow", "Clear Remap Palette", nullptr));
        actionPurgePendingActions->setText(QApplication::translate("MainWindow", "Purge Pending Actions", nullptr));
        actionContents->setText(QApplication::translate("MainWindow", "Quick How To Use", nullptr));
        actionHelpAbout->setText(QApplication::translate("MainWindow", "About", nullptr));
        menu_File->setTitle(QApplication::translate("MainWindow", "&File", nullptr));
        menu_Map->setTitle(QApplication::translate("MainWindow", "&Map", nullptr));
        menu_Help->setTitle(QApplication::translate("MainWindow", "&Help", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
