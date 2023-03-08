/*
// Date: 2023-03-07
// Developer: Hyperling
// Purpose: Keep main file clean by holding types (interfaces and vars) here.
*/

interface record {
	user_id: number;
	cal_date: string;
	meal: string; // Only wants options: Breakfast, Lunch, Dinner, Snack.
	food: string;
	caused_issue: boolean;
	comments: string;
}
