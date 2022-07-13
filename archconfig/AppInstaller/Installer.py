class Installer:

    def __init__(install, packages):
        install.settings = packages
        if install.settings["aur"][1] == True:
            install.aurInstall()
    
    
    def aurInstall(install):
        aur = install.settings["aur"][0]
        print(f"Installing {aur} AUR")
    
    def environmentInstall(install):
        pass
    
    def displayInstall(install):
        pass
    
    def packageInstall(install):
        pass
    
