#-------------------------------------------------
# Project created by Erik Courtecuisse & Ismael Zemmouj
#       with QtCreator 2018-10-27T14:53:30
#-------------------------------------------------

QT += core gui
QT += widgets uitools

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = IHM-miniProjet-1
TEMPLATE = app

DEFINES += QT_DEPRECATED_WARNINGS

CONFIG += c++11

SOURCES += \
        main.cpp \
        textfinder.cpp

HEADERS += \
        textfinder.h \
    darkstyle.h

FORMS += \
        textfinder.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

RESOURCES += \
    textfinder.qrc
