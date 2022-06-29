#!/bin/bash
cd ScriptInstaller/
message "Adding custom commands"
load "../_lib/scriptInstallers.sh"
addScriptstoBin "bashscripts"
lockAltTab "dconf"
progressMessage "Custom Commands installed"
