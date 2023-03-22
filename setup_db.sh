#!/bin/bash
# Date: 2023-03-22
# Developer: Hyperling
# Purpose: Check if tables exist and if not then creates them

DIR=`dirname $0`
PROG=`basename $0`
if [[ $DIR == "." ]]; then
	DIR="`pwd`"
	echo $DIR/$PROG
fi
DB="$DIR/db/main"
DEBUG="$1"

## Functions ##

function check_table {
	# Validate that the table exists in the database. If so then sqlite returns
	#  the DDL used to create it and we return success (0). Otherwise fail (1).
	table_name="$1"
	echo "Checking for $table_name..."
	typeset -l result
	result=`
		sqlite3 $DB <<- EOF
			.schema $table_name
		EOF
	`
	[[ -n $DEBUG ]] && echo $result
	if [[ $result == *"create table $table_name"* ]]; then
		echo "Found it!"
		return 0
	fi
	echo "Table not found."
	return 1
}

function run_ddl {
	# 
	file_name="$1"
	echo "Running $file_name..."
	sqlite3 $DB <<- EOF
		.echo on
		.read $file_name
	EOF
}

function list_ddl {
	# List the full path of the table files which need to be run.
	ls $DIR/db/DDL/*
}

## Main ##
echo "Ensuring DDL is applied and all patches are complete."

# Lop through tables and their DDL.
list_ddl | while read table_file; do
	echo "*** $table_file ***"
	
	# Get the name of the table based on the filename with no extension.
	table=`basename $table_file`
	table=${table//.sql/}

	# Check for the table.
	check_table $table || {
		# If the check fails, run the create statement.
		run_ddl $table_file && {
			# If the create succeeds, check for the table.
			check_table $table || {
				# If the check fails (again), throw an error and quit.
				echo "ERROR: Could not create $table!"
				exit 1
			}
		}
	}
	echo "Success!"
done

exit 0
