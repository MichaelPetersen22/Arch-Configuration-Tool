#!/bin/bash
addScriptstoBin() {
    scriptPath=$1
    echo "Copying custom scripts to /usr/bin"
    cp -f "${scriptPath}/"* /bin
}
