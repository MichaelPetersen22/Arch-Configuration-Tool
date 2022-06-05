#!/bin/bash

pkgInstall() {
    packagelist=$1
    message=$2
    message "$2"
    unset message
    cat "$packagelist" | while read -r line; do
        message "Installing $line"
        pacman -S --needed $line --noconfirm >/dev/null
        progressMessage "$line installed"
    done
    unset packagelist
}

gitInstaller() {
    repositoryvars=$1
    consolemessage=$2
    pacman -S --needed git --noconfirm &>/dev/null

    message "$consolemessage"
    unset consolemessage

    load "$repositoryvars"

    cd /tmp

    clearFiles "yay"
    clearFiles "whitesur-theme"
    clearFiles "tela-icons"
    clearFiles "layan-cursors"

    clone "$yay" "yay"
    clone "$theme" "whitesur-theme"
    clone "$icons" "tela-icons"
    clone "$cursor" "layan-cursors"

    ## Install YAY
    message "Installing YAY"
    cd /tmp/yay
    sudo -u $username makepkg -si --noconfirm
    progressMessage "YAY installed"

    ## Install Theme
    message "Installing Whitesur Theme"
    cd /tmp/whitesur-theme
    ./install.sh -c Dark -i arch
    progressMessage "Whitesur theme installed"

    ## Install Icons
    message "Installing Tela Icon Theme"
    cd /tmp/tela-icons
    ./install.sh
    progressMessage "Tela Icon Theme installed"

    ## Install Cursor
    message "Installing Layan Cursors"
    cd /tmp/layan-cursors
    ./install.sh
    progressMessage "Layan Cursors Installed"
    loadWorkingDir
    cd AppInstaller/
}

yayInstaller() {
    packagelist=$1
    message=$2
    message "$2"
    unset message
    cat $packagelist | while read -r line; do
        message "Installing $line"
        sudo -u $username yay -S $line --noconfirm >/dev/null
        progressMessage "$line installed"
    done
    unset packagelist
}
