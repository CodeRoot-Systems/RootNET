QT += quick
CONFIG += c++11
INCLUDEPATH = /usr/include/python3.6m
LIBS += -lpython3.6m

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    venv/lib/python3.6/config-3.6m-x86_64-linux-gnu/config.c

RESOURCES += qml.qrc \


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/bin/Tools/ \

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    bin/auth/profiler.py \
    bin/xsession/pages/Archive.qml \

HEADERS += \
    venv/include/python3.6m/abstract.h \
    venv/include/python3.6m/accu.h \
    venv/include/python3.6m/asdl.h \
    venv/include/python3.6m/ast.h \
    venv/include/python3.6m/bitset.h \
    venv/include/python3.6m/bltinmodule.h \
    venv/include/python3.6m/boolobject.h \
    venv/include/python3.6m/bytearrayobject.h \
    venv/include/python3.6m/bytes_methods.h \
    venv/include/python3.6m/bytesobject.h \
    venv/include/python3.6m/cellobject.h \
    venv/include/python3.6m/ceval.h \
    venv/include/python3.6m/classobject.h \
    venv/include/python3.6m/code.h \
    venv/include/python3.6m/codecs.h \
    venv/include/python3.6m/compile.h \
    venv/include/python3.6m/complexobject.h \
    venv/include/python3.6m/datetime.h \
    venv/include/python3.6m/descrobject.h \
    venv/include/python3.6m/dictobject.h \
    venv/include/python3.6m/dtoa.h \
    venv/include/python3.6m/dynamic_annotations.h \
    venv/include/python3.6m/enumobject.h \
    venv/include/python3.6m/errcode.h \
    venv/include/python3.6m/eval.h \
    venv/include/python3.6m/fileobject.h \
    venv/include/python3.6m/fileutils.h \
    venv/include/python3.6m/floatobject.h \
    venv/include/python3.6m/frameobject.h \
    venv/include/python3.6m/funcobject.h \
    venv/include/python3.6m/genobject.h \
    venv/include/python3.6m/graminit.h \
    venv/include/python3.6m/grammar.h \
    venv/include/python3.6m/import.h \
    venv/include/python3.6m/intrcheck.h \
    venv/include/python3.6m/iterobject.h \
    venv/include/python3.6m/listobject.h \
    venv/include/python3.6m/longintrepr.h \
    venv/include/python3.6m/longobject.h \
    venv/include/python3.6m/marshal.h \
    venv/include/python3.6m/memoryobject.h \
    venv/include/python3.6m/metagrammar.h \
    venv/include/python3.6m/methodobject.h \
    venv/include/python3.6m/modsupport.h \
    venv/include/python3.6m/moduleobject.h \
    venv/include/python3.6m/namespaceobject.h \
    venv/include/python3.6m/node.h \
    venv/include/python3.6m/object.h \
    venv/include/python3.6m/objimpl.h \
    venv/include/python3.6m/odictobject.h \
    venv/include/python3.6m/opcode.h \
    venv/include/python3.6m/osdefs.h \
    venv/include/python3.6m/osmodule.h \
    venv/include/python3.6m/parsetok.h \
    venv/include/python3.6m/patchlevel.h \
    venv/include/python3.6m/pgen.h \
    venv/include/python3.6m/pgenheaders.h \
    venv/include/python3.6m/py_curses.h \
    venv/include/python3.6m/pyarena.h \
    venv/include/python3.6m/pyatomic.h \
    venv/include/python3.6m/pycapsule.h \
    venv/include/python3.6m/pyconfig.h \
    venv/include/python3.6m/pyctype.h \
    venv/include/python3.6m/pydebug.h \
    venv/include/python3.6m/pydtrace.h \
    venv/include/python3.6m/pyerrors.h \
    venv/include/python3.6m/pyexpat.h \
    venv/include/python3.6m/pyfpe.h \
    venv/include/python3.6m/pygetopt.h \
    venv/include/python3.6m/pyhash.h \
    venv/include/python3.6m/pylifecycle.h \
    venv/include/python3.6m/pymacconfig.h \
    venv/include/python3.6m/pymacro.h \
    venv/include/python3.6m/pymath.h \
    venv/include/python3.6m/pymem.h \
    venv/include/python3.6m/pyport.h \
    venv/include/python3.6m/pystate.h \
    venv/include/python3.6m/pystrcmp.h \
    venv/include/python3.6m/pystrhex.h \
    venv/include/python3.6m/pystrtod.h \
    venv/include/python3.6m/Python-ast.h \
    venv/include/python3.6m/Python.h \
    venv/include/python3.6m/pythonrun.h \
    venv/include/python3.6m/pythread.h \
    venv/include/python3.6m/pytime.h \
    venv/include/python3.6m/rangeobject.h \
    venv/include/python3.6m/setobject.h \
    venv/include/python3.6m/sip.h \
    venv/include/python3.6m/sliceobject.h \
    venv/include/python3.6m/structmember.h \
    venv/include/python3.6m/structseq.h \
    venv/include/python3.6m/symtable.h \
    venv/include/python3.6m/sysmodule.h \
    venv/include/python3.6m/token.h \
    venv/include/python3.6m/traceback.h \
    venv/include/python3.6m/tupleobject.h \
    venv/include/python3.6m/typeslots.h \
    venv/include/python3.6m/ucnhash.h \
    venv/include/python3.6m/unicodeobject.h \
    venv/include/python3.6m/warnings.h \
    venv/include/python3.6m/weakrefobject.h \
    venv/lib/python3.6/site-packages/wheel/test/headers.dist/header.h
