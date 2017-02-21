#!/bin/sh

set -x

VERSION=0.1
LINUX_BIN=elmer-package-${VERSION}-linux.zip
MACOS_BIN=elmer-package-${VERSION}-darwin.zip

pushd linux-bin

zip ${LINUX_BIN} ./elmer-package

popd

pushd macos-bin

zip ${MACOS_BIN} ./elmer-package

popd

mv ./linux-bin/${LINUX_BIN} ./app/public/downloads/
mv ./macos-bin/${MACOS_BIN} ./app/public/downloads/
