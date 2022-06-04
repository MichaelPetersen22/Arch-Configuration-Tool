#!/bin/bash
### Messaging
message() {
    _message=$1
    echo $'\e[0;36m'$_message$'\e[0m'
    unset _message
}
progressMessage() {
    _message=$1
    echo $'\e[0;32m'$_message$'\e[0m'
    unset _message
}

warningMessage() {
    _message=$1
    echo $'\e[0;33m'$_message$'\e[0m'
    unset _message
}

exitMessage() {
    _message=$1
    echo $'\e[0;31m'$_message$'\e[0m'
    unset _message
}
#-----END OF MESSAGING FUNCTIONS

### Error Handling
setError() {
    _errormessage=$1
    _error='true'
}

checkError() {
    location=$1
    if [[ $_error == 'true' ]]; then
        warningMessage "$_errormessage"
        exitMessage "$location Errors Detected!!! Exiting Program..."
        exit 1
    else
        progressMessage "$location No errors detected, continuing program..."
    fi
}

#-----END OF ERROR HANDLING FUNCTIONS

load() {
    file=$1
    if test -f "$file"; then
        source $file
        progressMessage "$file loaded"
    else
        warningMessage "$file does not exist"
    fi
}

userCheck() {
    if [ $(logname) == "root" ]; then
        setError "User logged in as root, It is unsafe to run the program in root"
    fi
    if [ $USER != "root" ]; then
        setError "Program must be run with sudo"
    fi
    checkError "USERCHECK:"
    username=$(logname)
}
