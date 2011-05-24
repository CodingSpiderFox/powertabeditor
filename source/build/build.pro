include (../../common.pri)

TARGET = ../powertabeditor
TEMPLATE = app
CONFIG -= staticlib

LIBS += \
    -L../app/$${BUILDTYPE} -lapp \
    -L../widgets/$${BUILDTYPE} -lwidgets\
    -L../dialogs/$${BUILDTYPE} -ldialogs \
    -L../actions/$${BUILDTYPE} -lactions \
    -L../audio/$${BUILDTYPE} -lpteaudio \
    -L../audio/rtmidi/$${BUILDTYPE} -lrtmidi \
    -L../painters/$${BUILDTYPE} -lpainters \
    -L../powertabdocument/$${BUILDTYPE} -lpowertabdocument

# Link to appropriate libraries for RtMidi
win32:LIBS += -lwinmm
unix:LIBS += -lasound -lpthread
macx:LIBS += -framework CoreMidi -framework CoreAudio -framework CoreFoundation

win32:LIB_EXT='lib'
unix:LIB_EXT='a'

PRE_TARGETDEPS += \
    ../app/$${BUILDTYPE}/libapp.$${LIB_EXT} \
    ../widgets/$${BUILDTYPE}/libwidgets.$${LIB_EXT} \
    ../dialogs/$${BUILDTYPE}/libdialogs.$${LIB_EXT} \
    ../actions/$${BUILDTYPE}/libactions.$${LIB_EXT} \
    ../audio/$${BUILDTYPE}/libpteaudio.$${LIB_EXT} \
    ../audio/rtmidi/$${BUILDTYPE}/librtmidi.$${LIB_EXT} \
    ../painters/$${BUILDTYPE}/libpainters.$${LIB_EXT} \
    ../powertabdocument/$${BUILDTYPE}/libpowertabdocument.$${LIB_EXT}

SOURCES += main.cpp

RESOURCES += resources.qrc

# if shadow building is enabled
!equals($${PWD}, $${OUT_PWD}) {

    # commands to copy files from the current directory to the output directory
    win32 {
    CHECK_DIR_EXIST = IF EXIST
    OR = else
    MAKE_DIR = mkdir
    COPY = xcopy /E /Y
    THEN = (
    DONE_IF = )
    }
    unix|macx {
    CHECK_DIR_EXIST = test -d
    OR = ||
    MAKE_DIR = mkdir
    COPY = cp -r -u
    THEN = &&
    DONE_IF = ''
    }


    # select the right subfolder
    CONFIG(release, debug|release) {
     BUILD_TYPE = release
    } else {
     BUILD_TYPE = debug
    }

    # specify files for copying
    SOURCE_SKINS = $${PWD}/../skins
    win32:DEST_SKINS = $${OUT_PWD}/$${BUILD_TYPE}/skins
    unix|macx:DEST_SKINS = $${OUT_PWD}/

    # replace '/' with '\' in Windows paths
    win32 {
    SOURCE_SKINS = $${replace(SOURCE_SKINS, /, \\)}
    DEST_SKINS = $${replace(DEST_SKINS, /, \\)}
    }

    CHECK_DEST_SKINS_DIR_EXIST = $$CHECK_DIR_EXIST $$DEST_SKINS
    MAKE_DEST_SKINS_DIR = $$MAKE_DIR $$DEST_SKINS
    COPY_COMPILED_TRANSLATIONS = $$COPY $$SOURCE_SKINS $$DEST_SKINS

    QMAKE_POST_LINK += $$CHECK_DEST_SKINS_DIR_EXIST \
    $${THEN} $$COPY_COMPILED_TRANSLATIONS $${DONE_IF} $${OR} \
    $$MAKE_DEST_SKINS_DIR && $$COPY_COMPILED_TRANSLATIONS
}
