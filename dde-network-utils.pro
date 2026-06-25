QT       -= gui
QT       += dbus network

TARGET = gxde-network-utils-qt6
TEMPLATE = lib
CONFIG += link_pkgconfig c++17 create_pc create_prl no_install_prl no_keywords

# Qt6 version of dframeworkdbus (libdframeworkdbus-qt6)
DFRAMEWORK_PATH = $$(DFRAMEWORK_PATH)
isEmpty(DFRAMEWORK_PATH) {
    INCLUDEPATH += /usr/include/libdframeworkdbus-qt6-6.0
} else {
    INCLUDEPATH += $$DFRAMEWORK_PATH/include/libdframeworkdbus-qt6-6.0
    LIBS += -L$$DFRAMEWORK_PATH/lib
}
LIBS += -ldframeworkdbus-qt6

DEFINES += DDENETWORKUTILS_LIBRARY
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
    $$PWD/networkmodel.cpp \
    $$PWD/networkworker.cpp \
    $$PWD/networkdevice.cpp \
    $$PWD/wirelessdevice.cpp \
    $$PWD/wireddevice.cpp \
    $$PWD/connectivitychecker.cpp

HEADERS += \
    $$PWD/networkmodel.h \
    $$PWD/networkworker.h \
    $$PWD/networkdevice.h \
    $$PWD/wirelessdevice.h \
    $$PWD/wireddevice.h \
    $$PWD/connectivitychecker.h

includes.files += *.h
includes.files += \
    $$PWD/NetworkModel \
    $$PWD/NetworkWorker \
    $$PWD/NetworkDevice \
    $$PWD/WirelessDevice \
    $$PWD/WiredDevice

isEmpty(PREFIX) {
    PREFIX = /usr
}

# Automating generation .qm files from .ts files
CONFIG(release, debug|release) {
    !system($$PWD/translate_generation.sh): error("Failed to generate translation")
}

target.path = $$PREFIX/lib
includes.path = $$PREFIX/include/libgxde-network-utils-qt6

qm_files.path = $${PREFIX}/share/gxde-network-utils-qt6/translations/
qm_files.files = translations/*.qm

TRANSLATIONS = translations/gxde-network-utils-qt6.ts

QMAKE_PKGCONFIG_NAME = libgxde-network-utils-qt6
QMAKE_PKGCONFIG_DESCRIPTION = GXDE Network Utils Qt6 library
QMAKE_PKGCONFIG_INCDIR = $$includes.path
QMAKE_PKGCONFIG_LIBDIR = $$target.path
QMAKE_PKGCONFIG_DESTDIR = pkgconfig

INSTALLS += includes target qm_files
