#!/usr/bin/env python3

from helpers import process
from simple_term_menu import TerminalMenu
import json
from os.path import exists

# TODO Add Error Handling


class Interface:

    # Properties
    dualboot = ['', False]
    grub = ['', False]
    desktopenvironment = ['', False]
    displaymanager = ['', False]
    aur = ['', False]
    packagelist = ['', False]
    packages = []

    # Class Constructor
    def __init__(UI):
        UI.title()
        UI.menu()

    @staticmethod
    def title():
        print(r"""
░██████╗██╗░░░██╗░██████╗░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
██╔════╝╚██╗░██╔╝██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
╚█████╗░░╚████╔╝░╚█████╗░██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
░╚═══██╗░░╚██╔╝░░░╚═══██╗██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
██████╔╝░░░██║░░░██████╔╝╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
╚═════╝░░░░╚═╝░░░╚═════╝░░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░""")

    def menu(UI):
        prompt = True
        while(prompt):
            grub = ' '.join(UI.grub[:-1])
            opts = [
                '[1] Dual Boot ' + UI.dualboot[0],
                '[2] Grub Theme ' + grub,
                '[3] Desktop Environment ' + UI.desktopenvironment[0],
                '[4] Display Manager ' + UI.displaymanager[0],
                '[5] AUR Helper ' + UI.aur[0],
                '[6] Package List ' + UI.packagelist[0],
                '[7] Save Configuration File',
                '[8] Load Configuration File',
                None,
                '[9] Continue',
                '[0] Abort']
            menu = TerminalMenu(opts, skip_empty_entries=True)
            selection = menu.show()
            match selection:
                case 0:
                    UI.dualboot = UI.dualbootmenu()
                case 1:
                    UI.grub = UI.grubmenu()
                case 2:
                    UI.desktopenvironment = UI.desktopenvironmentmenu()
                case 3:
                    UI.displaymanager = UI.displaymanagermenu()
                case 4:
                    UI.aur = UI.aurmenu()
                case 5:
                    UI.packagelist = UI.packagemenu()
                case 6:
                    UI.saveconfig()
                case 7:
                    UI.loadconfig()
                case 9:
                    if UI.packagelist[1]:
                        UI.packageenabler(UI.packagelist)
                    prompt = False
                case 10:
                    process("clear")
                    print("Exiting Program")
                    exit()

    def dualbootmenu(UI):
        temp = input("Please Input Dual Boot Partition: ")
        print("\033[A                             \033[A")
        if not temp:
            return ['', False]
        else:
            return [temp, True]

    def grubmenu(UI):
        initops = ['Theme Select', 'Clear']
        initMenu = TerminalMenu(initops)
        selection = initMenu.show()
        match selection:
            case 0:
                pass
            case 1:
                return ['', False]

        themes = ['tela', 'vimix', 'stylish', 'whitesur']
        menu = TerminalMenu(themes)
        selection = menu.show()
        theme = themes[selection]

        icons = ['color', 'white', 'whitesur']
        menu = TerminalMenu(icons)
        selection = menu.show()
        icon = icons[selection]

        screens = ['1080p', '2k', '4k']
        menu = TerminalMenu(screens)
        selection = menu.show()
        screen = screens[selection]

        return [theme, icon, screen, True]

    def desktopenvironmentmenu(UI):
        initops = ['Environment Select', 'Clear']
        initMenu = TerminalMenu(initops)
        selection = initMenu.show()
        match selection:
            case 0:
                pass
            case 1:
                return ['', False]

        environments = ['i3', 'budgie']
        menu = TerminalMenu(environments)
        selection = menu.show()
        environment = environments[selection]

        return [environment, True]

    def displaymanagermenu(UI):
        initops = ['Manager Select', 'Clear']
        initMenu = TerminalMenu(initops)
        selection = initMenu.show()
        match selection:
            case 0:
                pass
            case 1:
                return ['', False]

        managers = ['ly', 'gdm', 'budgie']
        menu = TerminalMenu(managers)
        selection = menu.show()
        manager = managers[selection]

        return [manager, True]

    def aurmenu(UI):
        initops = ['Manager Select', 'Clear']
        initMenu = TerminalMenu(initops)
        selection = initMenu.show()
        match selection:
            case 0:
                pass
            case 1:
                return ['', False]

        aurs = ['yay', 'snap']
        menu = TerminalMenu(aurs)
        selection = menu.show()
        aur = aurs[selection]

        return [aur, True]

    # TODO Rewrite Messaging system to not leave behind any logged errors
    def packagemenu(UI):
        initops = ['List Select', 'Clear']
        initMenu = TerminalMenu(initops)
        selection = initMenu.show()
        match selection:
            case 0:
                pass
            case 1:
                return ['', False]
        prompt = True
        while(prompt):
            path = input("Please input path to package list: ")
            print(
                "\033[A                                                                        \033[A")
            if exists(path):
                with open(path) as apps:
                    installmode = "pacman"
                    index = 0
                    for line in apps:
                        if("AUR" in line):
                            installmode = "AUR"
                        if line.startswith("##") or not line.strip() or line.startswith("-"):
                            continue
                        splitline = line.split()

                        if len(splitline) == 2 and splitline[1] == "enable":
                            enabled = True
                        else:
                            enabled = False
                        UI.packages.append(
                            [splitline[0], installmode, enabled])
                        index += 1
                prompt = False
                return[path, True]
            elif not path:
                print("No path provided, Exiting Function")
                input()
                print(
                    "\033[A                                                                        \033[A")
                print(
                    "\033[A                                                                        \033[A")
                return['', False]
            else:
                print("File does not exist")

    def packageenabler(UI, packagelist):
        menuops = []
        preselected = []
        index = 0
        with open(packagelist[0]) as apps:
            for line in apps:
                if line.startswith("#") or line.startswith("-") or not line.strip():
                    continue
                split = line.split()
                
                if len(split) == 2 and split[1] == "enable":
                    preselected.append(index)
                menuops.append(split[0])
                index += 1
            menu = TerminalMenu(
                menuops, multi_select=True, title="Enable any autostart apps", preselected_entries=preselected,
                multi_select_select_on_accept=False, multi_select_empty_ok=True
            )
            selection = menu.show()
            for index in selection:
                UI.packages[index][2] = True

    def saveconfig(UI):
        config = {
            'dualboot': UI.dualboot,
            'grub': UI.grub,
            'desktopenvironment': UI.desktopenvironment,
            'displaymanager': UI.displaymanager,
            'aur': UI.aur,
            'packagelist': UI.packagelist,
        }

        jsonconfig = json.dumps(config)
        with open('config.json', 'w') as output:
            output.write(jsonconfig)
            print("Config File Saved")
            input()
            print("\033[A                             \033[A")
            print("\033[A                             \033[A")

    def loadconfig(UI):
        prompt = True
        while(prompt):
            path = input("Please input path to config file: ")
            print(
                "\033[A                                                                        \033[A")
            if exists(path):
                with open(path) as jsonfile:
                    data = json.load(jsonfile)
                    UI.dualboot = data['dualboot']
                    UI.grub = data['grub']
                    UI.desktopenvironment = data['desktopenvironment']
                    UI.displaymanager = data['displaymanager']
                    UI.aur = data['aur']
                    print("Config File Loaded")
                    input()
                    print("\033[A                             \033[A")
                    print("\033[A                             \033[A")
                    prompt = False
            else:
                print("Config File Not Found")

    def properties(UI):
        data = {
            'dualboot': UI.dualboot,
            'grub': UI.grub,
            'desktopenvironment': UI.desktopenvironment,
            'displaymanager': UI.displaymanager,
            'aur': UI.aur,
            'packagelist': UI.packagelist,
            'packages': UI.packages
        }

        return data
