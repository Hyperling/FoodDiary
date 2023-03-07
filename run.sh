#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Install all dependencies and run the project.

# Install any system packages.
if [[ -z `which npm` ]]; then
	echo "NPM needs to be installed."
	sudo apt install npm
else
	echo "NPM is already installed."
fi

# Install/update any project modules.
echo "Ensuring NPM packages are correct."
npm install package.json

# Start backend
node ./server.js

# Start frontend.
# ???
