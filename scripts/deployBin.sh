#!/bin/sh

set -xe

VERSION=0.1
LINUX_DIST=elmer-package-${VERSION}-linux.tar.gz
MACOS_DIST=elmer-package-${VERSION}-darwin.tar.gz
DIST_DIR=./elmer-package-${VERSION}

pushd linux-bin

mkdir ${DIST_DIR}
cp ../elm-package/LICENSE ${DIST_DIR}
cp elmer-package ${DIST_DIR}
tar -cvzf ${LINUX_DIST} ${DIST_DIR}
rm -rf ${DIST_DIR}

popd

pushd macos-bin

mkdir ${DIST_DIR}
cp ../elm-package/LICENSE ${DIST_DIR}
cp elmer-package ${DIST_DIR}
tar -cvzf ${MACOS_DIST} ${DIST_DIR}
rm -rf ${DIST_DIR}

popd

mv ./linux-bin/${LINUX_DIST} ./app/public/downloads/
mv ./macos-bin/${MACOS_DIST} ./app/public/downloads/
