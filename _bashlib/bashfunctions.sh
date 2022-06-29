#!/bin/bash
# @file bashfunctions
# @description helper functions for the script

# @description message function (outputs in yellow color)
# @params message: message to output to console
warningMessage() {
    _message=$1
    echo -e $'\e[0;33m'$_message$'\e[0m'
    unset _message
}

# @description message function (outputs in red color)
# @params message: message to output to console
exitMessage() {
    _message=$1
    echo -e $'\e[0;31m'$_message$'\e[0m'
    unset _message
}
#-----END OF MESSAGING FUNCTIONS

### Error Handling

# @description indicates an error has occured to the program
# @params message: error message to output to console
setError() {
    _errormessage+="$1\n"
    _error='true'
}

# @description Checks if error has occured, will log message defined in setError() here
# @params location: function / script location where error is being thrown
checkError() {
    location=$1
    if [[ $_error == 'true' ]]; then
        warningMessage "$_errormessage"
        exitMessage "$location Errors Detected!!! Exiting Program..."
        exit 1
    fi
}

#-----END OF ERROR HANDLING FUNCTIONS

# @description Checks program is being executed with the right privileges being set
userCheck() {
    if [ $(logname) == "root" ]; then
        setError "User logged in as root, It is unsafe to run the program in root"
    fi
    if [ $USER != "root" ]; then
        setError "Program must be run with sudo"
    fi
    checkError "BASH USERCHECK:"
    username=$(logname)
}
