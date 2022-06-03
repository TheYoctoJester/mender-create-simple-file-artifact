#!/bin/sh -l

env
echo "RUNNER_WORKSPACE in entrypoint.sh: $RUNNER_WORKSPACE"
cd /home/user/mender-artifact
./mender-artifact -h
ls -ahl ~
ls -ahl $RUNNER_WORKSPACE
tree /github