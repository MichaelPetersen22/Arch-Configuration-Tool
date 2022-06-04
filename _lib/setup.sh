#!/bin/bash
setAltTab() {
    workingDIR=$(pwd)
    cd /home/"$username"/.config/autostart
    echo "resetAltTab" >setAltTab.sh
    chmod +x setAltTab.sh
    cd "$workingDIR"/
}

copyAutostartApps() {
    cp Config/files/plank.desktop /home/"$username"/.config/autostart
}
