#!/bin/bash
pkgInstall() {
    packagelist=$1
    message=$2
    message "$2"
    cat "$packagelist" | while read -r line; do
        pacman -S --needed $line --noconfirm >/dev/null
        echo "$line installed"
    done
}

gitInstaller() {
    # Install git if not installed
    pacman -S --needed git --noconfirm
    repositories=$1
    message "$2"
    load $1
    workingDIR=$(pwd)
    cd /tmp
    rm -r -f yay-bin
    rm -r -f Whitesur-gtk-theme
    rm -r -f Tela-icon-theme
    rm -r -f Layan-cursors
    message "Cloning Yay"
    sudo -u $username git clone $yay &>/dev/null
    message "Cloning WhiteSur GTK Theme"
    sudo -u $username git clone $theme &>/dev/null
    message "Cloning Tela Icon Theme"
    sudo -u $username git clone $icons &>/dev/null
    message "Cloning Layan Cursors"
    sudo -u $username git clone $cursor &>/dev/null

    ## Install YAY
    cd /tmp/yay-bin
    sudo -u $username makepkg -si --noconfirm

    ## Install Theme
    cd /tmp/WhiteSur-gtk-theme
    ./install.sh -c Dark -i arch

    ## Install Icons
    cd /tmp/Tela-icon-theme
    ./install.sh

    ## Install Cursor
    cd /tmp/Layan-cursors
    ./install.sh
    cd "$workingDIR"/
    unset workingDIR

}

yayInstaller() {
    packagelist=$1
    message=$2
    message "$2"
    cat $packagelist | while read -r line; do
        sudo -u $username yay -S $line --noconfirm >/dev/null
        echo $line installed
    done
}
