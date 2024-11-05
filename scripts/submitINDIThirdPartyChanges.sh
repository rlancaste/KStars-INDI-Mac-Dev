#!/bin/bash

#	Submit Changes scripts
#﻿   Copyright (C) 2024 Robert Lancaster <rlancaste@gmail.com>
#	This script is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public
#	License as published by the Free Software Foundation; either
#	version 2 of the License, or (at your option) any later version.

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Prepare to run the script by setting all of the environment variables	
	source "${DIR}/submit-engine.sh"

# This section sets the critical options for finding the repo and forked src folder.
	export FORKED_REPO="git@github.com:${GIT_USERNAME}/indi-3rdparty.git"	
	export SRC="${FORKED_SRC_FOLDER}/indi-3rdParty"

# Display the message explaining what this script does.
	display "This script will submit your INDI 3rd Party Changes in the forked repo.  You must have made changes in the forked-src folder for this to work."

# Before starting, check to see if the remote server is accessible
	checkForConnection "${FORKED_REPO}"
	
# Check to make sure that you are not in the master branch, and make a branch if needed.
# Then committing changes in the new branch or the current branch
# Then sending the changes to the server
	commitAndPushToServer

# Display the final message
	display "Please go to https://github.com/${GIT_USERNAME}/indi-3rdparty.git and click the submit pull request button if you are ready to make your pull request, or make other changes and other commits first."



		