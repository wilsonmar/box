var self = main;
module.exports = self;

var mongoose = require('mongoose');
var async = require('async');
var _ = require('underscore');
var fs = require('fs');

var box = require('./Model.js');
var DB_URL = process.env.DB_URL;
var DB_NAME = process.env.DB_NAME;
var CRON_INTERVAL = 5 * 1000; // 5 seconds
var RANDOM_NUMBER = process.env.RANDOM_NUMBER.toString();
var ENVIRONMENT = process.env.ENVIRONMENT;
var COLOR = '#000';

function worker() {
  var oldBox = {
    random: RANDOM_NUMBER
  };
  var updatedBox = {
    $set: {
      color: COLOR,
      random: RANDOM_NUMBER,
      environment: ENVIRONMENT,
      updatedAt: Date.now()
    }
  };
  console.log(updatedBox);
  box.update(oldBox,updatedBox,{upsert:true}, function (err) {
    if (err) {
      console.log('Error while updating box: ',err);
    }
    else {
      console.log('Updated the box');
    }
    console.log('Going for sleep for ',CRON_INTERVAL/1000,' seconds');
    _.delay(worker, CRON_INTERVAL);
  });
}

function connectToMongo(callback) {
  mongoose.connect(DB_URL +'/'+ DB_NAME, {}, function (err) {
    if (err)
      console.log('Error connecting to mongo database: ', err);
    else {
      console.log('Successfully connected to mongo');
    }
    return callback(err);
  });
}

function checkEnvironmentVariables() {
  if (!ENVIRONMENT)
    return 'ENVIRONMENT not found';
  if (!RANDOM_NUMBER)
    return 'RANDOM_NUMBER not found';
  if (!DB_URL)
    return 'DB_URL not found';
  if (!DB_NAME)
      return 'DB_NAME not found';
}

function readColor() {
  COLOR = require('./color.js').color;
}

function main() {
  console.log('Starting cron');
  var err = checkEnvironmentVariables();
  if (err)
    console.log('Error: ',err);
  else
    connectToMongo(
      function (err) {
        if (err)
          console.log('Fatal Error in connecting to mongo. Shutting Down');
        else {
          readColor();
          worker();
        }
      }
    );
}

main();
