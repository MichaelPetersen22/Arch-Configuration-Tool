#!/bin/bash
cd ScriptInstaller/
message "Adding custom commands"
load "../_lib/scriptInstallers.sh"
addScriptstoBin "bashscripts"
progressMessage "Custom Commands installed"
