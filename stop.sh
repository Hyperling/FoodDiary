#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Turn off the project since the subprocesses run as forks.

## Stop all services. ##

# Kill frontend.
# killall `pwd`/index.tsx >stop.log 2>&1

# Kill backend
killall `pwd`/server.js >stop.log 2>&1

