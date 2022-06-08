#!/bin/sh -l

env

cd /home/user/mender-artifact

sudo mkdir -p $GITHUB_WORKSPACE/output
sudo chown $(whoami):$(whoami) $GITHUB_WORKSPACE/output

echo "creating the artifact..."
./mender-artifact write module-image \
  -T single-file \
  --device-type testdevice1 \
  -o $GITHUB_WORKSPACE/output/simpledummy_1.0.mender \
  -n simpledummy-1.0 \
  --software-name simpledummy \
  --software-version 1.0 \
  -f $GITHUB_WORKSPACE/input/payload
echo "... done"

echo "uploading the artifact..."
curl -s -X POST https://hosted.mender.io/api/management/v1/deployments/artifacts \
  -H 'Content-Type: multipart/form-data' \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $JWT" \
  -F artifact=@$GITHUB_WORKSPACE/output/simpledummy_1.0.mender
echo "... done"
