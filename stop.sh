#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Turn off the project since the subprocesses run as forks.

DIR=`dirname $0`
PROG=`basename $0`
if [[ $DIR == "." ]]; then
	DIR="`pwd`"
	echo $DIR/$PROG
fi

## Stop all services. ##

# Kill frontend.
# killall $DIR//index.tsx >$DIR/logs/stop.log 2>&1

# Kill backend
killall $DIR/server.js >$DIR/logs/stop.log 2>&1
