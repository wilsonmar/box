#!/bin/bash -e
if [ "$IS_PULL_REQUEST" != true ]; then
  export TAG=$BRANCH.$BUILD_NUMBER
  echo $TAG

  sudo docker push $IMAGE_NAME:$TAG
else
  echo "skipping because it's a PR"
fi
