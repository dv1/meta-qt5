
# We override this completely to eliminate the -e normally passed in
EXTRA_OEMAKE = ' MAKEFLAGS= '

export OE_QMAKE_CC="${CC}"
export OE_QMAKE_CFLAGS="${CFLAGS}"
export OE_QMAKE_CXX="${CXX}"
export OE_QMAKE_LDFLAGS="${LDFLAGS}"
export OE_QMAKE_AR="${AR} cqs"
export OE_QMAKE_STRIP="echo"
export OE_QMAKE_RPATH="-Wl,-rpath-link,"

# do not export STRIP to the environment
STRIP[unexport] = "1"

do_generate_qt_config_file() {

    export QT_CONF_PATH=${WORKDIR}/qt.conf
    cat > ${WORKDIR}/qt.conf <<EOF
[Paths]
Binaries = ${bindir}
Headers = ${STAGING_INCDIR}/qt5
Plugins = ${libdir}/qt5/plugins
Libraries = ${STAGING_LIBDIR}
Imports = ${datadir}/qt5/imports
Qml2Imports = ${libdir}/qt5/qml
Documentation=${docdir}/qt5
Data = ${datadir}/qt5
HostData = ${STAGING_DATADIR}/qt5
HostBinaries = ${STAGING_BINDIR_NATIVE}
EOF

}

addtask generate_qt_config_file after do_patch before do_configure
