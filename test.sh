#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Create a test user and some test data.

DIR=`dirname $0`
PROG=`basename $0`
if [[ $DIR == "." ]]; then
	DIR="`pwd`"
	echo $DIR/$PROG
fi

## Create User ##

# curl POST test_user test_password etc etc

## Create Entries ##

# curl POST test_user 2023-03-07 "Mangoes and rice" FALSE "Yummy!"

