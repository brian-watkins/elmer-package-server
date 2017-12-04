#!/bin/sh

set -e

if [ $# -ne 1 ]
  then
    echo "makeElmDoc <path to elmer>"
    exit 0
fi

ELMER_DIR=${1}
ELMER_PACKAGE_SERVER_PUBLIC_DIR=./app/public

pushd elm-doc

. ./bin/activate

./bin/elm-doc ${ELMER_DIR} \
  --output docs \
  --exclude 'Elmer.Context,Elmer.TestState,Elmer.Http.Internal,Elmer.Printer,Elmer.Navigation.Location,Elmer.Html.Types,Elmer.Html.Query,Elmer.Html.Event.Types,Elmer.Html.Event.HandlerQuery,Elmer.Html.Event.Description,Elmer.Html.Event.Processor,Elmer.Internal,Elmer.Runtime,Elmer.Runtime.Intention,Elmer.Runtime.Types,Elmer.Runtime.Command,Elmer.Headless.Internal,Elmer.Platform.Internal,Elmer.Http.Server,Elmer.Html.Internal,Elmer.Spy.Internal' \
  --elm-make /usr/local/bin/elm-make

popd

( set -x
  cp -R ./elm-doc/docs/assets ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}
  cp -R ./elm-doc/docs/artifacts ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}
  mkdir -p ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/packages/brian-watkins/elmer
  cp -R ./elm-doc/docs/packages/brian-watkins/elmer/* ${ELMER_PACKAGE_SERVER_PUBLIC_DIR}/packages/brian-watkins/elmer/
)
