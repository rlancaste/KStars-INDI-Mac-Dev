#!/bin/bash

#	Submit Changes script
#﻿   Copyright (C) 2019 Robert Lancaster <rlancaste@gmail.com>
#	This script is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public
#	License as published by the Free Software Foundation; either
#	version 2 of the License, or (at your option) any later version.

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Prepare to run the script by setting all of the environment variables	
	source "${DIR}/build-env.sh"
	
display "This script will submit your INDI 3rd Party Changes in the forked repo.  You must have made changes in the forked-src folder for this to work."

# This checks if any of the path variables are blank, since if they are blank, it could start trying to do things in the / folder, which is not good
	if [[ -z ${FORKED_SRC_FOLDER} || -z ${FORKED_THIRDPARTY_REPO} ]]
	then
  		display "One or more critical directory variables is blank, please edit build-env.sh."
  		exit 1
	fi

# Check to see that the user has actually already make a forked source folder for INDI 3rd Party
if [ ! -d "${FORKED_SRC_FOLDER}/indi-3rdParty" ]
then
	echo "No Forked INDI 3rd Party git repo detected.  Please make sure to fork the repo, edit build-env.sh, run setup.sh, and make changes to submit."
	exit
fi

# Change to the forked source directory so that the changes can be submitted.
	cd "${FORKED_SRC_FOLDER}/indi-3rdParty"
	
# Check to make sure that you are not in the master branch, and make a branch if needed.
# Then committing changes in the new branch or the current branch
# Then sending the changes to the server
	branch=$(git rev-parse --abbrev-ref HEAD)
	echo "You are on branch ${branch}"
	read -p "Do you want to switch to another branch before committing? Type y for yes." switch
	if [[ "$branch" == "master" && "$switch" != "y" ]]
	then
		echo "You should not commit or submit your changes to the master branch.  This script will not do that. Make another branch for changes to submit."
		read -p "Hit [Enter] to end the script now." closing
		exit
	elif [[ "$switch" == "y" ]]
	then
		read -p "What do you want your new branch to be called?" newBranch
		git checkout -b "${newBranch}"
		read -p "Please type a message for your commit: " commitMsg
		git commit -am "${commitMsg}"
		git push -u origin "${newBranch}"
	else
		read -p "Please type a message for your commit: " commitMsg
		git commit -am "${commitMsg}"
		git push -u origin "$branch"
	fi
	
display "Please go to https://github.com/${GIT_USERNAME}/indi-3rdparty.git and click the submit pull request button if you are ready to make your pull request, or make other changes and other commits first."



		