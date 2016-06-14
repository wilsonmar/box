#!/bin/bash -e
BODY=$(<./body.json)
echo "$BODY"

PROJECT_URL='http://localhost:50000/projects/575fa22f71af9ded209ea4f2/newBuild'
curl -H "Content-Type: application/json" -H "Authorization: apiToken $SHIPPABLE_API_TOKEN" -X POST -d "$BODY" $PROJECT_URL