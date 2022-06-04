#!/bin/bash
windowsPartition=$1
source _lib/helpers.sh
userCheck
if [ -z $windowsPartition ]; then
    setError "No windows partition provided"
    checkError "WINDOWSPARTITIONCHECK: "
fi
. ./AppInstaller/install.sh
load _lib/scriptBin.sh


# Options:
# theme: tela | vimix | stylish | whitesur
# icon: color | white | whitesur
# screen: 1080p | 2k | 4k

. ./Config/grubConfig.sh "whitesur" "color" "1080p" $windowsPartition AppInstaller/packagelists/repos.sh


. ./Config/configureFirefox.sh
. ./Config/zshConfig.sh
. ./Config/autostartConfig.sh