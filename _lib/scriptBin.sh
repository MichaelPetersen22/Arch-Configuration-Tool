#!/bin/bash
addScriptstoBin() {
    echo "Copying custom scripts to /usr/bin"
    cp Bash_scripts/* /usr/bin
}

setAltTab() {
    workingDIR=$(pwd)
    cd /home/"$username"/.config/autostart
    echo "resetAltTab" >setAltTab.sh
    chmod +x setAltTab.sh
    cd "$workingDIR"/
}
