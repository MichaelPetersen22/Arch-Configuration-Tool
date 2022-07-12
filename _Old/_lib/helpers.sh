#!/bin/bash
# @file helpers
# @description helper functions for the script

### Messaging
# @description message function (outputs text in cyan color)
# @params message: message to output to console
message() {
    _message=$1
    echo -e $'\e[0;36m'$_message$'\e[0m'
    unset _message
}

# @description message function (outputs in green color)
# @params message: message to output to console
progressMessage() {
    _message=$1
    echo -e $'\e[0;32m'$_message$'\e[0m'
    unset _message
}

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

### Utilities

# @description Loads bash scripts to program, throws error when file does not exist
# @params location: function / script location where error is being thrown
load() {
    _file=$1
    if test -f "$_file"; then
        source $_file
        progressMessage "$_file loaded"
    else
        warningMessage "$_file does not exist"
    fi
    unset _file
}

# @description Checks program is being executed with the right privileges being set
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

# @description If file exists, deletes file
# @params file: file to be deleted / checked
clearFiles() {
    _file=$1
    if [ test -f "$_file" ] &>/dev/null; then
        rm -rf $_file
    fi
    unset _file
}

# @description Sets variables for use in program
setVars(){
    USER_DIR="/home/$username"
    _workingDIR=$(pwd)
}

# @description Changes program location back to original directory
loadWorkingDir(){
    cd "$_workingDIR"/
}

# @description If file exists, deletes file
# @params repository: the repository to be cloned  name: the name of the folder to clone into
clone(){
    _repository=$1
    _name=$2
    message "Cloning $_name"
    sudo -u $username git clone "$_repository" "$_name"
    progressMessage "$_name cloned"
    unset _repository
    unset _name
}


# @description prints help options to console
showHelp() {
    cat <<EOF
    Usage: $0 [OPTION]...


    -d, --dual  PARTITION                       Option provided to installer tells it to set up GRUB to Dual Boot another OS and provide OS boot partition
    -gt, --grubtheme theme icons screen         Allows user to select grub theme options
                                                theme:          tela  | vimix | stylish | whitesur
                                                icons:          color | white | whitesur
                                                screen:         1080p |  2k   |   4k  
    
    -h, --help                                  Shows this help menu
EOF
}

#-----END OF UTILITIES
