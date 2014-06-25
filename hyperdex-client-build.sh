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
if [ ! -e "$JSON_C" ]; then
    tar xzf "$ROOT/deps/$JSON_C.tar.gz"
fi
cd "$JSON_C"
./configure --prefix="$BUILD"
make
make install

# Build po6
cd "$BUILD_TMP"
if [ ! -e "PO6" ]; then
    tar xzf "$ROOT/deps/$PO6.tar.gz"
fi
cd "$PO6"
./configure --prefix="$BUILD"
make
make install

# Build e
cd "$BUILD_TMP"
if [ ! -e "$E" ]; then
    tar xzf "$ROOT/deps/$E.tar.gz"
fi
cd "$E"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib"
make
make install

# Build BusyBee
cd "$BUILD_TMP"
if [ ! -e "$BUSYBEE" ]; then
    tar xzf "$ROOT/deps/$BUSYBEE.tar.gz"
fi
cd "$BUSYBEE"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib" \
    E_CFLAGS=-I"${BUILD}/include" E_LIBS=-L"${BUILD}/lib"
make
make install

# Build Replicant
cd "$BUILD_TMP"
if [ ! -e "$REPLICANT" ]; then
    tar xzf "$ROOT/deps/$REPLICANT.tar.gz"
fi
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
if [ ! -e "$HYPERDEX" ]; then
    tar xzf "$ROOT/deps/$HYPERDEX.tar.gz"
fi
cd "$HYPERDEX"
./configure --prefix="$BUILD" \
    PO6_CFLAGS=-I"${BUILD}/include" PO6_LIBS=-L"${BUILD}/lib" \
    E_CFLAGS=-I"${BUILD}/include" E_LIBS=-L"${BUILD}/lib" \
    BUSYBEE_CFLAGS=-I"${BUILD}/include" BUSYBEE_LIBS=-L"${BUILD}/lib" \
    --disable-all-components --enable-client
make
make install

# Build Node Bindings
# includes and libs in ${BUILD}
cd "$BUILD_TMP"
cd "$HYPERDEX"
cd bindings/node.js
node-gyp configure
CFLAGS=-I"${BUILD}/include" LDFLAGS=-L"${BUILD}/lib" node-gyp build
cp build/Release/hyperdex-client.node "$BUILD"

# Cleanup
rm -rf "$BUILD_TMP"
