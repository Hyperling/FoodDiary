/*
// Date: 2023-03-07
// Developer: Hyperling
// Purpose: Provide an API for the UI to hit, decoupling the DB code.
*/
"use strict";

/* Usage */

function usage (exit_code) {
	console.log(
		process.argv[1] + " is used to expose the SQLite backend to React.\n" +
		"  It accepts the following parameters: \n" + 
		"    -h or --help: Display this usage text.\n" +
		"    /path/to/project: Where the project lives and the db + scripts exist."
	);
	process.exit(exit_code);
}

/* Arguments */

let DIR = "";
if (process.argv.length == 2 || process.argv.length >= 4 || process.argv[2] == undefined) {
  console.log('Expected one argument!');
  usage(1);
} else if (process.argv[2] === "-h" || process.argv[2] === "--help") {
	usage(0);
} else {
	DIR = process.argv[2];
	console.log("Successfully got DIR: ", DIR);
}

/* Setup */

const sqlite3 = require('sqlite3').verbose();

async function finish () {
	await db.close();
}

/* Main Program */

async function main() {
	console.log("Connecting to DB "+DIR+"/db/main");
	let db = await new sqlite3.Database(DIR+"/db/main");
	console.log(db);
	try {
		await db.run(`
			CREATE TABLE journal (
				user_id				INTEGER NOT NULL,
				cal_date 			TEXT NOT NULL,
				meal 					TEXT NOT NULL,
				food 					TEXT NOT NULL,
				caused_issue 	INTEGER NOT NULL,
				comments 			TEXT
			) STRICT
		`);
	} catch (e) {
		console.log("Table not created.")
	} finally {
		let r = await db.get(`
			SELECT count(*) FROM journal
		`);
		console.log(r);
	}
}

main();
