#!/bin/bash
pkgli="packagelists"
cd AppInstaller/
source "../_lib/helpers.sh"
load "../_lib/packageInstallers.sh"
pkgInstall "$pkgli/gpu.txt" "Installing gpu drivers"
pkgInstall "$pkgli/coreUTIL.txt" "Installing core utilities"
pkgInstall "$pkgli/coreGUI.txt" "Installing user interface utilities"
pkgInstall "$pkgli/appList.txt" "Installing Apps"
gitInstaller "$pkgli/repos.sh" "Installing GIT Applications"
yayInstaller "$pkgli/yayPKGS.txt" "Installing Yay Applications"
cd ..