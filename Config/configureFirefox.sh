#!/bin/bash
message "Installing Firefox Configuration"
sudo -u $username timeout 5s firefox --headless --first-startup &>/dev/null
killall "firefox" "firefox-bin" &>/dev/null || true
HomeDIR="/home/$username/.mozilla/firefox"
firefoxReleaseDIR="${HomeDIR}/"*"default-release"*
sed -i 's/user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);//g' $firefoxReleaseDIR/prefs.js
sed -i '/^$/d' $firefoxReleaseDIR/prefs.js
echo "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);" >>$firefoxReleaseDIR/prefs.js

release=$(sed -n "2p" /home/$username/.mozilla/firefox/installs.ini)
release=$(echo $release | sed 's/^Default=//')
mkdir /home/$username/.mozilla/firefox/$release/chrome
cp -R "Config/files/userChrome.css" /home/$username/.mozilla/firefox/$release/chrome

progressMessage "Browser Configured"
