#!/bin/bash
# Date: 2023-03-07
# Developer: Hyperling
# Purpose: Install all dependencies and run the project.

if [[ -z `which npm` ]]; then
	sudo apt install npm
fi

npm install package.json

# ???
