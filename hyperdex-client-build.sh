#!/bin/bash

set -e

ROOT=`pwd`
BUILD=$ROOT/build
BUILD_TMP=$BUILD/tmp
PLATFORM=`uname`

mkdir -p $BUILD_TMP

JSON_C_VERSION=0.11
JSON_C=json-c-$JSON_C_VERSION

PO6_VERSION=0.6.dev
PO6=libpo6-$PO6_VERSION

E_VERSION=0.7.dev
E=libe-$E_VERSION

BUSYBEE_VERSION=0.5.dev
BUSYBEE=busybee-$BUSYBEE_VERSION

REPLICANT_VERSION=0.6.dev
REPLICANT=replicant-$REPLICANT_VERSION

HYPERDEX_VERSION=1.3.dev
HYPERDEX=hyperdex-$HYPERDEX_VERSION

# Build json-c
cd "$BUILD_TMP"
tar xzf "$ROOT/$JSON_C.tar.gz"
cd "$JSON_C"
./configure --prefix="$BUILD"
make
make install

# Build po6
cd "$BUILD_TMP"
tar xzf "$ROOT/$PO6.tar.gz"
cd "$PO6"
./configure --prefix="$BUILD"
make
make install

# Build e
cd "$BUILD_TMP"
tar xzf "$ROOT/$E.tar.gz"
cd "$E"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib"
make
make install

# Build BusyBee
cd "$BUILD_TMP"
tar xzf "$ROOT/$BUSYBEE.tar.gz"
cd "$BUSYBEE"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib" \
    E_CFLAGS=-I"${BUILD}/include" E_LIBS=-L"${BUILD}/lib"
make
make install

# Build Replicant
cd "$BUILD_TMP"
tar xzf "$ROOT/$REPLICANT.tar.gz"
cd "$REPLICANT"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib" \
    E_CFLAGS=-I"${BUILD}/include" E_LIBS=-L"${BUILD}/lib" \
    BUSYBEE_CFLAGS=-I"${BUILD}/include" BUSYBEE_LIBS=-L"${BUILD}/lib" \
    --disable-all-components --enable-client
make
make install

# Build HyperDex
cd "$BUILD_TMP"
tar xzf "$ROOT/$HYPERDEX.tar.gz"
cd "$HYPERDEX"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib" \
    E_CFLAGS=-I"${BUILD}/include" E_LIBS=-L"${BUILD}/lib" \
    BUSYBEE_CFLAGS=-I"${BUILD}/include" BUSYBEE_LIBS=-L"${BUILD}/lib" \
    --disable-all-components --enable-client
make
make install

# Build Node Bindings
# XXX need build the bindings/node.js dir of HyperDex and link against the
# includes and libs in ${BUILD}

# Cleanup
rm -r "$BUILD_TMP"
