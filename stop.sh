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

## Stop Frontend Services ##
# Kill the frontend if it's still rnning for some reason.
# ???

## Stop Backend Services ##

# Let backend know it's time to close then loop over status until it stops.
echo "Stopping the backend service."
# curl POST localhost:8080/stop
count=1
still_up="Y"
while [[ $still_up == "Y" ]]; do
	echo "Check #$count"
	if (( $count >= 20 )); then
		# Force kill backend if we have gone through 20 rounds.
		killall $DIR/dist/server.js
	fi

	# curl GET localhost:8080/check_status
	status=$?

	if [[ $status != 0 ]]; then
		still_up="N"
	fi

	count=$(( count + 1 ))
	sleep 1
done
