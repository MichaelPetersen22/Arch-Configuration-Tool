from git import Repo
import os
from helpers import clone, build
class Installer:

    def __init__(install, packages):
        install.settings = packages
        if install.settings["aur"][1]:
            install.aurInstall()
        if install.settings["desktopenvironment"][1]:
            install.environmentInstall()
        if install.settings["displaymanager"][1]:
            install.displayInstall()
        if install.settings["packagelist"][1]:
            pkgs = install.settings["packages"]
            install.packageInstall(pkgs)
    
    
    def aurInstall(install):
        aur = install.settings["aur"][0]
        print(f"Installing {aur} AUR")
        
        if aur == 'yay':
            path = '/tmp/yay'
            clone("https://aur.archlinux.org/yay-bin.git", path)
            build(path)
        elif aur == 'pikaur':
            path = '/tmp/pikaur'
            clone("https://aur.archlinux.org/pikaur.git", path)
            build(path)
        elif aur == 'trizen':
            path = '/tmp/trizen'
            clone("https://aur.archlinux.org/trizen.git", path)
            build(path)
        else:
            raise InvalidSelection(f"AUR {aur} is an invalid selection")
            
    def environmentInstall(install):
        pass
    
    def displayInstall(install):
        pass
    
    def packageInstall(install, packages):
        pass
    
class InvalidSelection(Exception):
    pass