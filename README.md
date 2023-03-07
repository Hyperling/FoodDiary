# food_diary
Food Diary UI

## What
Simple application for entering food choices and whether they caused any issues
such as headaches, migraines, upset digestion, etc. 

## Installation / How To Run
This project assumes an apt-based OS. It is currently being developed on Ubuntu.

Clone the project:

`git clone https://github.com/Hyperling/food_diary food_diary_app`

Move into the directory:

`cd food_diary_app`

Run the project:

`./run.sh`

### Different Environments
The project can also safely run the project from another directory so that it's
safe to be called from things like cron or if you're feeling lazy and don't want
to move your terminal location. 

Such as something like this for doing development testing:

`bash ~/Projects/git/food_diary_app`

Or maybe something like these in a more production-like environment:

`bash /opt/FoodDiary/run.sh`

`bash /usr/local/src/food_diary_app/run.sh`

#### Caveat
These create `package*.json` files in the local directory which will need
cleaned or ignored. The `node_modules` folder is moved to the project directory.

## Testing
`test.sh` has been provided for showing how to interact with the APIs.
