#!/bin/bash

export readonly RANDOM_NUMBER=$(date +%s-%N)
cd /home/harry/box

echo 'cron running without forever'
node cron.js
