CREATE TABLE journal (
	user_id      INTEGER NOT NULL,
	cal_date     TEXT NOT NULL,
	meal         TEXT NOT NULL,
	food         TEXT NOT NULL,
	caused_issue INTEGER NOT NULL,
	comments     TEXT
) STRICT;
