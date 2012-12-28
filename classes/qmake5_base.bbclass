QMAKE_MKSPEC_PATH ?= "${STAGING_DATADIR_NATIVE}/qmake"

OE_QMAKE_PLATFORM = "${TARGET_OS}-oe-g++"
QMAKESPEC := "${QMAKE_MKSPEC_PATH}/${OE_QMAKE_PLATFORM}"

# We override this completely to eliminate the -e normally passed in
EXTRA_OEMAKE = ' MAKEFLAGS= '

QT_DIR_NAME ?= "qt5"

export OE_QMAKE_CC="${CC}"
export OE_QMAKE_CFLAGS="${CFLAGS}"
export OE_QMAKE_CXX="${CXX}"
export OE_QMAKE_LDFLAGS="${LDFLAGS}"
export OE_QMAKE_AR="${AR} cqs"
export OE_QMAKE_STRIP="echo"
export OE_QMAKE_RPATH="-Wl,-rpath-link,"
export QT_CONF_PATH="${WORKDIR}/qt.conf"
export QT_DIR_NAME

# do not export STRIP to the environment
STRIP[unexport] = "1"

do_generate_qt_config_file() {
    cat > ${QT_CONF_PATH} <<EOF
[Paths]
Binaries = ${bindir}
Headers = ${includedir}/${QT_DIR_NAME}
Plugins = ${libdir}/${QT_DIR_NAME}/plugins
Libraries = ${libdir}
Imports = ${datadir}/${QT_DIR_NAME}/imports
Qml2Imports = ${libdir}/${QT_DIR_NAME}/qml
Documentation = ${docdir}/${QT_DIR_NAME}
Data = ${datadir}/${QT_DIR_NAME}
HostData = ${STAGING_DATADIR}/${QT_DIR_NAME}
HostSpecPath = ${QMAKE_MKSPEC_PATH}/
HostBinaries = ${STAGING_BINDIR_NATIVE}
EOF
}

addtask generate_qt_config_file after do_patch before do_configure
