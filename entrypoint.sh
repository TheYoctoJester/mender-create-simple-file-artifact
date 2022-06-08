#!/bin/sh -l

env

cd /home/user/mender-artifact
./mender-artifact write module-image \
  -T single-file \
  --device-type testdevice1 \
  -o $GITHUB_WORKSPACE/dist/simpledummy_1.0.mender \
  -n simpledummy-1.0 \
  --software-name simpledummy \
  --software-version 1.0 \
  -f $GITHUB_WORKSPACE/dist/payload

tree $GITHUB_WORKSPACE