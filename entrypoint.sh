#!/bin/sh -l

env
echo "home in entrypoint.sh: $HOME"
cd /home/user/mender-artifact
./mender-artifact -h
ls -ahl ~