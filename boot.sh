#!/bin/bash

export readonly RANDOM_NUMBER=$(date +%s-%N)
cd /home/harry/box

if [[ ENVIRONMENT='local' ]]; then
  echo 'cron running with forever'
  forever -w -v cron.js
else
  echo 'cron running without forever'
  node cron.js
fi
