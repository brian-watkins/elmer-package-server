#!/bin/sh

set -xe

ELMER_DIR=${1}
ELMER_PACKAGE_SERVER_PUBLIC_DIR=./app/public

pushd elm-doc

source ./bin/activate

elm-doc ${ELMER_DIR} \
  --output docs \
  --exclude 'Elmer.Http.Internal,Elmer.Printer,Elmer.Navigation.Location,Elmer.Html.Types,Elmer.Html.Query,Elmer.Internal,Elmer.Platform,Elmer.Runtime,Elmer.Command.Internal,Elmer.Http.Server,Elmer.Html.Internal'

popd

rm -rf ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/assets
rm -rf ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/artifacts
rm -rf ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/packages

cp -R ./elm-doc/docs/assets ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}
cp -R ./elm-doc/docs/artifacts ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}
mkdir ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/packages
cp -R ./elm-doc/docs/packages/brian-watkins ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/packages/
