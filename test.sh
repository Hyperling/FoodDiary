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

## Create Test User ##

# insert into user values (-1, 'Hyperling', 'SuperSecretPassword')

## Create Entries ##

# Manually
sqlite3 $DIR/db/main <<- EOF
	.headers on
	.echo on

	delete from journal where user_id = -1;

	insert into journal (user_id, cal_date, meal, food, caused_issue, comments)
	values (-1, '2023-03-22', 'Breakfast', 'Mango', '1', null);
	insert into journal (user_id, cal_date, meal, food, caused_issue, comments)
	values (-1, '2023-03-22', 'Lunch', 'Greasy restaurant food', '0', null);
	insert into journal (user_id, cal_date, meal, food, caused_issue, comments)
	values (-1, '2023-03-22', 'Snack', 'Rice and beans', '1', null);
	insert into journal (user_id, cal_date, meal, food, caused_issue, comments)
	values (-1, '2023-03-22', 'Dinner', 'Rice and beans', '1', null);

	select * from journal where user_id = -1;
EOF

## Via the API

# curl POST test_user 2023-03-07 "Mangoes and rice" FALSE "Yummy!"

## Remove any old test logs.
rm -rfv $DIR/logs
