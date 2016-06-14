#!/bin/bash -e
if [ "$IS_PULL_REQUEST" != true ]; then
  export TAG=$IMAGE_NAME:$BRANCH.$BUILD_NUMBER
  echo $TAG

  sudo docker push $IMAGE_NAME:$TAG
  sed -i -e 's/{TAG}/'$TAG'/g' body.json

  cat body.json
else
  echo "skipping because it's a PR"
fi
