#!/usr/bin/env python3
import subprocess, os

def process(cmd, silent = False):
    try:
        cmdsplit = cmd.split()
        with open('log.txt','w') as log:
            if(silent):
                task = subprocess.run(cmdsplit, check=True, stdout=subprocess.DEVNULL, stderr=log)
            else:
                command = subprocess.run(cmdsplit, check=True, stderr=log)
    except subprocess.CalledProcessError as err:
        print(err)
    except Exception as err:
        print("Unhandled Error Detected, Please contact development@michaelpetersen.co or develop error handling yourself.")
        print(err)
    if (os.stat('log.txt').st_size == 0) :
        os.remove('log.txt')

def installRequired():
    pass