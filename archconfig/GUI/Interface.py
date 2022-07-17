#!/usr/bin/env python3
# TODO Refactor Pass One Required

from cgitb import enable
from helpers import process
from simple_term_menu import TerminalMenu
import json
from os.path import exists

# TODO Add Error Handling
# TODO Add Property Assignment Functions with inbuilt error handling for values that properties should not be
# TODO Refactor Class Properties to use dictionaries (More reliable indexing)


class Interface:

    # Class Properties
    # Values are used in execution of the rest of the program
    execprops = {
        'Dual Boot': {
            'Drive': None or '',
            'Use': False
        },
        'Grub': {
            'Theme': None or '',
            'Icon': None or '',
            'Screen Size': None or '',
            'Use': False
        },
        'Desktop Environment': {
            'Environment': None or '',
            'Use': False
        },
        'Display Manager': {
            'Display': None or '',
            'Use': False
        },
        'AUR': {
            'Helper': None or '',
            'Use': False
        },
        'Package List': {
            'Path': None or '',
            'Use': False
        },
        'Packages': []
    }

    def __init__(interface):
        interface.title()
        interface.menu()

    @staticmethod
    def title():
        print(r"""
# ░██████╗██╗░░░██╗░██████╗░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
# ██╔════╝╚██╗░██╔╝██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
# ╚█████╗░░╚████╔╝░╚█████╗░██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
# ░╚═══██╗░░╚██╔╝░░░╚═══██╗██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
# ██████╔╝░░░██║░░░██████╔╝╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
# ╚═════╝░░░░╚═╝░░░╚═════╝░░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░""")

    def menu(interface):
        while(True):
            options = [
                f"[1] Dual Boot {interface.execprops['Dual Boot']['Drive']}".strip(
                ),
                f"[2] Grub Theme {interface.execprops['Grub']['Theme']} {interface.execprops['Grub']['Icon']} {interface.execprops['Grub']['Screen Size']}".strip(),
                f"[3] Desktop Environment {interface.execprops['Desktop Environment']['Environment']}".strip(
                ),
                f"[4] Display Manager {interface.execprops['Display Manager']['Display']}".strip(
                ),
                f"[5] AUR Helper {interface.execprops['AUR']['Helper']}".strip(),
                f"[6] Package List {interface.execprops['Package List']['Path']}".strip(
                ),
                "[7] Save Configuration File",
                "[8] Load Configuration File",
                None,
                "[9] Continue",
                "[0] Abort"
            ]

            menu = TerminalMenu(
                options, skip_empty_entries=True, menu_cursor=None)
            input = menu.show()

            match input:
                case 0:
                    interface.execprops['Dual Boot'] = interface.Dual_Boot()
                case 1:
                    interface.execprops['Grub'] = interface.Grub()
                case 2:
                    interface.execprops['Desktop Environment'] = interface.Desktop_Environment(
                    )
                case 3:
                    interface.execprops['Display Manager'] = interface.Display_Manager()
                case 9:
                    break
                case 10:
                    process("clear")
                    print("Exiting Program")
                    exit()

    def Dual_Boot(interface):
        temp = input("Please Input Dual Boot Partition: ")
        print("\033[A                             \033[A")
        if temp:
            return {
                'Drive': temp,
                'Use': True
            }
        else:
            return {
                'Drive': None or '',
                'Use': False
            }

    def Grub(interface):
        options = ['Theme Select', 'Clear']
        menu = TerminalMenu(options)
        input = menu.show()
        match input:
            case 0:
                pass
            case 1:
                return {
                    'Theme': None or '',
                    'Icon': None or '',
                    'Screen Size': None or '',
                    'Use': False
                }

        options = ['tela', 'vimix', 'stylish', 'whitesur']
        menu = TerminalMenu(options)
        input = menu.show()
        theme = options[input]

        options = ['color', 'white', 'whitesur']
        menu = TerminalMenu(options)
        input = menu.show()
        icon = options[input]

        options = ['1080p', '2k', '4k']
        menu = TerminalMenu(options)
        input = menu.show()
        screen = options[input]

        return {
            'Theme': theme,
            'Icon': icon,
            'Screen Size': screen,
            'Use': True
        }

    def Desktop_Environment(interface):
        options = ['Environment Select', 'Clear']
        menu = TerminalMenu(options)
        input = menu.show()
        match input:
            case 0:
                pass
            case 1:
                return {
                    'Environment': None or '',
                    'Use': False
                }
        options = ['i3', 'budgie']
        menu = TerminalMenu(options)
        input = menu.show()

        return {
            'Environment': options[input],
            'Use': True
        }

    def Display_Manager(interface):
        options = ['Display Select', 'Clear']
        menu = TerminalMenu(options)
        input = menu.show()
        match input:
            case 0:
                pass
            case 1:
                return {
                    'Display': None or '',
                    'Use': False
                }
        options = ['ly', 'gdm', 'budgie']
        menu = TerminalMenu(options)
        input = menu.show()
        
        return {
            'Display': options[input],
            'Use': True
        }
