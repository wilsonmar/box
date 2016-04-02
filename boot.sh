#!/bin/bash

export readonly RANDOM_NUMBER=$(date +%s-%N)
cd /home/dv

if [[ ENVIRONMENT='Local' ]]; then
  echo 'cron running with forever'
  forever -w -v cron.js
else
  echo 'cron running without forever'
  node /home/dv/cron.js
fi
