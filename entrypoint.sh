#!/bin/sh -l

env

cd /home/user/mender-artifact

sudo mkdir -p $GITHUB_WORKSPACE/output
sudo chown $(whoami):$(whoami) $GITHUB_WORKSPACE/output

ARTIFACT_NAME=${INPUT_SOFTWARE_NAME}_${INPUT_SOFTWARE_VERSION}.mender

echo "creating the artifact..."
./mender-artifact write module-image \
  -T single-file \
  --device-type $INPUT_DEVICE_TYPE \
  -o $GITHUB_WORKSPACE/output/$ARTIFACT_NAME \
  -n $INPUT_SOFTWARE_NAME-$INPUT_SOFTWARE_VERSION \
  --software-name $INPUT_SOFTWARE_NAME \
  --software-version $INPUT_SOFTWARE_VERSION \
  -f $GITHUB_WORKSPACE/input/payload
echo "... done"

echo "uploading the artifact..."
curl -s -X POST https://hosted.mender.io/api/management/v1/deployments/artifacts \
  -H 'Content-Type: multipart/form-data' \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $JWT" \
  -F artifact=@$GITHUB_WORKSPACE/output/$ARTIFACT_NAME
echo "... done"
