#!/bin/bash
addScriptstoBin() {
    scriptPath=$1
    echo "Copying custom scripts to /usr/bin"
    cp -f "${scriptPath}/"* /bin
}

lockAltTab(){
    dconfPath=$1
    mkdir -p /etc/dconf/profile/
    mkdir -p /etc/dconf/db/local.d/locks
    cp -f "${dconfPath}/user" /etc/dconf/profile/user
    cp -f "${dconfPath}/tablock.db" /etc/dconf/db/local.d/tablock.db
    cp -f "${dconfPath}/tablock.lock" /etc/dconf/db/local.d/locks/tablock.lock
    dconf update
}
