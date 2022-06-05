#!/bin/bash
cd ConfigurationInstaller/
load "../_lib/configurationInstallers.sh"
cfgPth="ConfigurationFiles"
setAutostart "$cfgPth"
userDirInstall "$cfgPth"
fontConfigure "$cfgPth"
zshConfigure "$cfgPth"
firefoxConfigure "$cfgPth"
grubConfigure "$gtheme" "$gicons" "$gscreen" "$dualboot" "$partition"
progressMessage "System Configured"
cd ..