message "Configuring ZSH"
sudo -u $username yay -S zsh-theme-powerlevel10k
workingDIR=$(pwd)
userDIR="/home/$username/"
cp -u Config/files/.zshrc "$userDIR"/

mkdir -p /usr/share/fonts
cd ../resources/fonts/
cp * /usr/share/fonts
message "Caching fonts"
fc-cache -f -v &>/dev/null
progressMessage "ZSH Configured"
