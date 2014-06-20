#!/bin/bash

ROOT=`pwd`
BUILD=$ROOT/build
BUILD_TMP=$BUILD/tmp
PLATFORM=`uname`

mkdir -p $BUILD_TMP

GLOG_VERSION=0.3.3
GLOG=glog-$GLOG_VERSION
GLOG_FILE=/$BUILD_TMP/$GLOG.tar.gz
GLOG_URL=https://google-glog.googlecode.com/files/$GLOG.tar.gz
POPT_VERSION=1.16
POPT=popt-$POPT_VERSION
POPT_FILE=/$BUILD_TMP/$POPT.tar.gz
POPT_URL=http://rpm5.org/files/popt/$POPT.tar.gz
JSON_C_VERSION=0.11
JSON_C=json-c-$JSON_C_VERSION
JSON_C_FILE=/$BUILD_TMP/$JSON_C.tar.gz
JSON_C_URL=https://s3.amazonaws.com/json-c_releases/releases/$JSON_C.tar.gz

if [ ! -f $BUILD/lib/libglog.la ] ; then
    if [ ! -f $GLOG_FILE ] ; then
        echo "Get $GLOG from $GLOG_URL"
        curl --silent --output $GLOG_FILE $GLOG_URL || wget $GLOG_URL -O $GLOG_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download Google Glog at $GLOG_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $GLOG_FILE && \
    cd $GLOG && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build Google Glog"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/libpopt.la ] ; then
    if [ ! -f $POPT_FILE ] ; then
        echo "Get $POPT from $POPT_URL"
        curl --silent --output $POPT_FILE $POPT_URL || wget $POPT_URL -O $POPT_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download libpopt at $POPT_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $POPT_FILE && \
    cd $POPT && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build libpopt"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/json-c.la ] ; then
    if [ ! -f $JSON_C_FILE ] ; then
        echo "Get $JSON_C from $JSON_C_URL"
        curl --silent --output $JSON_C_FILE $JSON_C_URL || wget $JSON_C_URL -O $JSON_C_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download json-c at $JSON_C_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $JSON_C_FILE && \
    cd $JSON_C && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build json-c"
        exit 1
    fi
    cd $ROOT
fi

export PKG_CONFIG_PATH=$BUILD/lib/pkgconfig
export CPPFLAGS=-I$BUILD/include
export LDFLAGS=-L$BUILD/lib

PO6_VERSION=0.5.0
PO6=libpo6-$PO6_VERSION
PO6_FILE=/$BUILD_TMP/$PO6.tar.gz
PO6_URL=http://hyperdex.org/src/$PO6.tar.gz
E_VERSION=0.7.0
E=libe-$E_VERSION
E_FILE=/$BUILD_TMP/$E.tar.gz
E_URL=http://hyperdex.org/src/$E.tar.gz
BUSYBEE_VERSION=0.5.0
BUSYBEE=busybee-$BUSYBEE_VERSION
BUSYBEE_FILE=/$BUILD_TMP/$BUSYBEE.tar.gz
BUSYBEE_URL=http://hyperdex.org/src/$BUSYBEE.tar.gz
HYPERLEVELDB_VERSION=1.1.0
HYPERLEVELDB=hyperleveldb-$HYPERLEVELDB_VERSION
HYPERLEVELDB_FILE=/$BUILD_TMP/$HYPERLEVELDB.tar.gz
HYPERLEVELDB_URL=http://hyperdex.org/src/$HYPERLEVELDB.tar.gz
REPLICANT_VERSION=0.6.0
REPLICANT=replicant-$REPLICANT_VERSION
REPLICANT_FILE=/$BUILD_TMP/$REPLICANT.tar.gz
REPLICANT_URL=http://hyperdex.org/src/$REPLICANT.tar.gz
HYPERDEX_VERSION=1.3.0
HYPERDEX=hyperdex-$HYPERDEX_VERSION
HYPERDEX_FILE=/$BUILD_TMP/$HYPERDEX.tar.gz
HYPERDEX_URL=http://hyperdex.org/src/$HYPERDEX.tar.gz

if [ ! -f $BUILD/lib/pkgconfig/libpo6.pc ] ; then
    if [ ! -f $PO6_FILE ] ; then
        echo "Get $PO6 from $PO6_URL"
        curl --silent --output $PO6_FILE $PO6_URL || wget $PO6_URL -O $PO6_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download libpo6 at $PO6_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $PO6_FILE && \
    cd $PO6 && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build libpo6"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/pkgconfig/libe.pc ] ; then
    if [ ! -f $E_FILE ] ; then
        echo "Get $E from $E_URL"
        curl --silent --output $E_FILE $E_URL || wget $E_URL -O $E_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download libe at $E_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $E_FILE && \
    cd $E && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build libe"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/pkgconfig/busybee.pc ] ; then
    if [ ! -f $BUSYBEE_FILE ] ; then
        echo "Get $BUSYBEE from $BUSYBEE_URL"
        curl --silent --output $BUSYBEE_FILE $BUSYBEE_URL || wget $BUSYBEE_URL -O $BUSYBEE_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download busybee at $BUSYBEE_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $BUSYBEE_FILE && \
    cd $BUSYBEE && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build busybee"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/pkgconfig/libhyperleveldb.pc ] ; then
    if [ ! -f $HYPERLEVELDB_FILE ] ; then
        echo "Get $HYPERLEVELDB from $HYPERLEVELDB_URL"
        curl --silent --output $HYPERLEVELDB_FILE $HYPERLEVELDB_URL || wget $HYPERLEVELDB_URL -O $HYPERLEVELDB_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download hyperleveldb at $HYPERLEVELDB_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $HYPERLEVELDB_FILE && \
    cd $HYPERLEVELDB && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build hyperleveldb"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/pkgconfig/replicant.pc ] ; then
    if [ ! -f $REPLICANT_FILE ] ; then
        echo "Get $REPLICANT from $REPLICANT_URL"
        curl --silent --output $REPLICANT_FILE $REPLICANT_URL || wget $REPLICANT_URL -O $REPLICANT_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download replicant at $REPLICANT_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $REPLICANT_FILE && \
    cd $REPLICANT && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build replicant"
        exit 1
    fi
    cd $ROOT
fi

if [ ! -f $BUILD/lib/libhyperdex-client.la ] ; then
    if [ ! -f $HYPERDEX_FILE ] ; then
        echo "Get $HYPERDEX from $HYPERDEX_URL"
        curl --silent --output $HYPERDEX_FILE $HYPERDEX_URL || wget $HYPERDEX_URL -O $HYPERDEX_FILE
        if [ $? != 0 ] ; then
            echo "Unable to download hyperdex at $HYPERDEX_URL"
            exit 1
        fi
    fi
    cd $BUILD_TMP
    tar -xzf $HYPERDEX_FILE && \
    cd $HYPERDEX && \
    ./configure --prefix=$BUILD && \
    make && \
    make install
    if [ $? != 0 ] ; then
        echo "Unable to build hyperdex"
        exit 1
    fi
    cd $ROOT
fi


if [ ! -f $BUILD/lib/libhyperdex-clien.la ] ; then
    cd $BUILD_TMP/$HYPERDEX/bindings/node.js && \
    $ROOT/node_modules/.bin/node-gyp configure build
    if [ $? != 0 ] ; then
        echo "Unable to build hyperdex node.js bindings"
        exit 1
    fi
    cd $ROOT
fi
