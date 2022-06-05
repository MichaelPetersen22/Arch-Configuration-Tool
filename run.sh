#!/bin/bash
# @file run
# @brief Main executable file for archpackager

source _lib/helpers.sh

## Flag parsing
while [[ $# -gt 0 ]]; do
    case "${1}" in
    -d | --dual)
        shift
        dualboot='true'
        partition=$1
        shift
        ;;
    -gt | --grubtheme)
        grubtheme='true'
        shift
        gtheme=$1
        shift
        gicons=$1
        shift
        gscreen=$1
        shift
        ;;
    -h | --help)
        showHelp
        exit 0
        ;;
    *)
        echo -e "ERROR: Unrecognized installation option '${1}'."
        echo "Try $0 --help for more information"
        exit 1
        ;;
    esac
done

userCheck
setVars

if [ $dualboot == 'true' ] &>/dev/null; then
    message "Using Dual Boot"
    if [ -z $partition ]; then
        setError "No windows partition provided"
        checkError "WINDOWSPARTITIONCHECK: "
    fi
else
    dualboot='false'
fi

if [ $grubtheme == 'true' ] &>/dev/null; then
    message "Using User Defined Grub Theme"
    if [ ! -z $gscreen ]; then
        if [[ ! $gtheme =~ ^("tela"|"vimix"|"stylish"|"whitesur")$ ]]; then
            setError "Invalid Theme parameter specified"
        fi
        if [[ ! $gicons =~ ^("color"|"white"|"whitesur")$ ]]; then
            setError "Invalid Icon parameter specified"
        fi
        if [[ ! $gscreen =~ ^("1080p"|"2k"|"4k")$ ]]; then
            setError "Invalid Screen parameter specified"
        fi
    else
        setError "Empty parameters detected!"
    fi
    checkError "GRUBPARAMS: "
else
    gtheme="whitesur"
    gicons="whitesur"
    gscreen="1080p"
fi

. ./AppInstaller/install.sh

. ./ConfigurationInstaller/install.sh

. ./ScriptInstaller/install.sh
