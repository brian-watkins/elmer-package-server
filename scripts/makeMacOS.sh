#!/bin/sh

set -xe

mkdir macos-tmp

cp -R ./elm-compiler ./macos-tmp/
cp -R ./elm-package ./macos-tmp/elmer-package

pushd macos-tmp

cabal sandbox init
cabal sandbox add-source ./elm-compiler
cabal install -j --only-dependencies --ghc-options="-w" ./elmer-package
cabal install -j ./elmer-package

popd

cp ./macos-tmp/.cabal-sandbox/bin/elmer-package ./macos-bin/

rm -rf ./macos-tmp
