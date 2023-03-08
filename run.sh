#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Install all dependencies and run the project.

DIR=`dirname $0`
PROG=`basename $0`
if [[ $DIR == "." ]]; then
	DIR="`pwd`"
	echo $DIR/$PROG
fi

## Install any system packages. ##

if [[ -z `which npm` || -z `which tsc` || -z `which sqlite` ]]; then
	echo "A dependency is missing, going through install process."
	sudo apt install npm node-typescript sqlite
else
	echo "All packages are available."
fi

## Install/update any project modules. ##

# Ensure it is safe to be running an npm nstall.
if [[ `pwd` != $DIR && -e package.json ]]; then
	cat <<- EOF
		WARNING: It seems you are currently in a different JS project which already 
		 has a package.json. Cannot guarantee safety of installing $DIR. Please
		 make sure you understand what you're doing before continuing.
	EOF
	printf "Would you like to continue? [N/y]: "
	typeset -u continue
	read continue
	if [[ $continue != Y* ]]; then
		echo "Good choice, exiting application."
		exit 1
	fi
fi

# Use package.json in project directory to evaluate if any modules need added.
echo "Refreshing NPM packages."
npm install $DIR

## Main ##

# Start backend in a forked process
echo "Starting back-end in a child process and sleeping for 5 seconds."
mkdir -p $DIR/db
node $DIR/dist/server.js "$DIR" >>$DIR/logs/server.log 2>&1 &
sleep 5

# Start frontend.
touch $DIR/dist &&
sh -c "rm -rv $DIR/dist" &&
tsc --project $DIR &&
ls -l $DIR/dist &&
# ??? $DIR/dist/index.js >$DIR/logs/ui.log 2>&1
echo "Started front-end successfully!" || 
echo "Failed to start front-end."
echo "Front-end service has stopped."

## Finish ##

# If we've reached this point then the front-end has been terminated and the
#  back-end needs to be stopped as well. use the helper script to do it
echo "Finishing the back-end as well."
$DIR/stop.sh
