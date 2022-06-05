#!/bin/bash
setAutostart() {
    message "Setting Applications to autostart"
    CONFIG_FILES_DIR=$1
    AUTOSTART_DIR="${USER_DIR}/.config/autostart/"
    cp -f "${CONFIG_FILES_DIR}/set-alt-tab.desktop" "${AUTOSTART_DIR}"
    cp -f "${CONFIG_FILES_DIR}/plank.desktop" "${AUTOSTART_DIR}"
    systemctl enable gdm
    systemctl enable firewalld
    unset AUTOSTART_DIR
    unset CONFIG_FILES_DIR
    progressMessage "Autostart Apps set"
}

userDirInstall() {
    message "Configuring User Directories"
    CONFIG_FILES_DIR=$1
    CONFIG_DIR="${USER_DIR}/.config"
    cp -f "${CONFIG_FILES_DIR}/user-dirs.dirs" "${CONFIG_DIR}"
    cp -f "${CONFIG_FILES_DIR}/user-dirs.conf" /etc/xdg/
    unset CONFIG_DIR
    unset CONFIG_FILES_DIR
    progressMessage "User Directories configured"
}

firefoxConfigure() {
    CONFIG_FILES_DIR=$1
    message "Installing Firefox Configuration"
    sudo -u $username timeout 5s firefox --headless --first-startup &>/dev/null
    killall "firefox" "firefox-bin" &>/dev/null || true
    HomeDIR="${USER_DIR}/.mozilla/firefox"
    firefoxReleaseDIR="${HomeDIR}/"*"default-release"*
    sed -i 's/user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);//g' $firefoxReleaseDIR/prefs.js
    sed -i '/^$/d' $firefoxReleaseDIR/prefs.js
    echo "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);" >>$firefoxReleaseDIR/prefs.js

    release=$(sed -n "2p" ${HomeDIR}/installs.ini)
    release=$(echo $release | sed 's/^Default=//')
    mkdir "${HomeDIR}/${release}/chrome" &>/dev/null
    cp -Rf "${CONFIG_FILES_DIR}/userChrome.css" "${HomeDIR}/${release}/chrome"
    unset CONFIG_FILES_DIR

    progressMessage "Browser Configured"
}

fontConfigure() {
    message "Installing Fonts"
    message "Installing Ubuntu Font"
    pacman -S --needed ttf-ubuntu-font-family --noconfirm &>/dev/null
    progressMessage "Ubuntu Font Installed"
    message "Installing Noto Fonts"
    sudo -u $username yay -S --needed noto-fonts-main --noconfirm &>/dev/null
    progressMessage "Noto fonts Installed"
    CONFIG_FILES_DIR=$1
    mkdir -p /usr/share/fonts
    cp -f "${CONFIG_FILES_DIR}/fonts/"* /usr/share/fonts
    message "Caching fonts"
    fc-cache -f -v &>/dev/null
    progressMessage "Fonts Configured"
    unset CONFIG_FILES_DIR
}

zshConfigure() {
    CONFIG_FILES_DIR=$1
    message "Configuring ZSH"
    sudo -u $username yay -S zsh-theme-powerlevel10k --noconfirm --needed &>/dev/null
    pacman -S zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search --noconfirm --needed &>/dev/null
    progressMessage "ZSH Requirements Installed"
    cp -f "${CONFIG_FILES_DIR}/.zshrc" "${USER_DIR}"/
    progressMessage "ZSH Configured"
    unset CONFIG_FILES_DIR
}

grubConfigure() {
    grubtheme=$1
    grubicon=$2
    grubscreen=$3
    dboot=$4
    sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    if [ $dboot == 'true' ] &>/dev/null; then
        message "Mounting OS boot partition"
        winPartition=$5
        umount -l --recursive /mnt
        mount /dev/"${winPartition}" /mnt
    fi
    cd /tmp
    message "Configuring GRUB"
    clone "$grub2theme" "Grub-Theme"
    cd /tmp/Grub-Theme
    ./install.sh -t $grubtheme -i $grubicon -s $grubscreen
    unset grubtheme
    unset grubicon
    unset grubscreen
    progressMessage "GRUB Configured"
    loadWorkingDir
    cd ConfigurationInstaller/
}
