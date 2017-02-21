#!/bin/sh

set -x

cwd=`pwd`

docker build -t haskell .
docker run -it -v ${cwd}/linux-bin:/opt/server/linux-bin haskell
