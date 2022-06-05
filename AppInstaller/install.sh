#!/bin/bash
cd AppInstaller/
message "Running App Installer"
sleep 2
pkgli="packagelists"
load "../_lib/appInstallers.sh"
pkgInstall "$pkgli/gpu.txt" "Installing gpu drivers"
pkgInstall "$pkgli/coreUTIL.txt" "Installing core utilities"
pkgInstall "$pkgli/coreGUI.txt" "Installing user interface utilities"
pkgInstall "$pkgli/appList.txt" "Installing Apps"
gitInstaller "$pkgli/repos.sh" "Installing GIT Applications"
yayInstaller "$pkgli/yayPKGS.txt" "Installing Yay Applications"

loadWorkingDir
progressMessage "App Installer Complete"