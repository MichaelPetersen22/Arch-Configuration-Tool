#!/bin/bash
setAltTab() {
    workingDIR=$(pwd)
    cd /home/"$username"/.config/autostart
    echo "resetAltTab" > setAltTab.sh
    chmod +x setAltTab.sh
    cd "$workingDIR"/
}
