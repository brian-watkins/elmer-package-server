#!/bin/sh

set -xe

mkdir elm-doc

python3 -m venv ./elm-doc

pushd elm-doc

source ./bin/activate

pip install --upgrade pip setuptools
pip install elm-doc
