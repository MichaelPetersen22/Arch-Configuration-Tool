## DISCLAIMER: This is a personal shell script I use to save time configuring fresh arch linux installs, it is public to save myself time from having to copy in a personal access token in a shell interface (no GUI)
### What this does
#### Installs Desktop Environment
Installs Budgie Desktop Environment + extensions (i.e. budgie-extras)  
Installs Nautilus File Manager  
Installs Tilix Terminal  
Installs Gnome Display Manager (gdm)  
Installs custom styling for theme, icons, cursor and GRUB bootloader  
Adds custom fonts MesloLGS, Noto sans and Ubuntu Monospace  

#### Installs Applications and Utilities
Installs yay AUR helper  
Installs required AMD GPU Drivers  
Installs Utilities such as Budgie Control Centre (Gnome Control center patched for Budgie Desktop)  
Installs personal apps such as spotify and steam  

#### Configures System
Configures grub for dual booting  
Sets applications to automatically start  
Adds Firefox Custom CSS  
Configures ZSH Styling and utilities such as command history and highlighting, neofetch on terminal open etc.  
Adds custom QoL scripts that I personally use when on linux (i.e. a command that synchronises and updates both pacman and AUR repositories)  
Fixes Budgie desktop issue with faulty alt tab behaviour by replacing locking the default budgie alt tab behaviour in dconf (linux registry)  
