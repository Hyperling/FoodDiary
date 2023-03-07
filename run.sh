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
if [[ -z `which npm` ]]; then
	echo "NPM needs to be installed."
	sudo apt install npm
else
	echo "NPM is already available."
fi

if [[ -z `which tsc` ]]; then
	echo "TSC needs to be installed."
	sudo apt install node-typescript
else
	echo "TSC is already available."
fi

## Install/update any project modules. ##
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
echo "Refreshing NPM packages."
bash -c "rm -r $DIR/node_modules $DIR/package-lock.json"
npm install $DIR

## Main ##

# Fork somehow other than just doing &? Then...

if [[ $parent ]]; then
	# Start backend
	node $DIR/server.js >$DIR/logs/server.log 2>&1 &
else
	# Start frontend.
	tsc --project $DIR
	# ??? $DIR/dist/index.js >$DIR/logs/ui.log 2>&1
fi

# Or just run them each with & and then kill with another shell script? stop.sh
