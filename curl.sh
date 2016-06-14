#!/bin/bash -e

BODY=$(<./body.json)
VERSION_URL='http://beta.shippable.com//v2/versions'

echo "$BODY"
curl -H "Content-Type: application/json" -H "Authorization: apiToken $SHIPPABLE_API_TOKEN" -X POST -d "$BODY" $VERSION_URL