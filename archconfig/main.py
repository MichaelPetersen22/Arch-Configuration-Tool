from GUI.Interface import Interface
from AppInstaller.Installer import Installer

from helpers import License
import sys
if __name__ == "__main__":
    License()
    Interface = Interface()
    data = Interface.properties()
    Installer = Installer(data)
