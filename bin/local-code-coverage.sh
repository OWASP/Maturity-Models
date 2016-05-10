#!/bin/bash

mocha --recursive --compilers coffee:coffee-script/register --require coffee-coverage/register-istanbul test
./node_modules/.bin/istanbul report
open ./coverage/lcov-report/index.html