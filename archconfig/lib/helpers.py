#!/usr/bin/env python3
import subprocess

def cmd(args, silent = True):
    try:
        with open('log.txt','w') as log:
            if(silent):
             command = subprocess.run(args, shell=True, check=True, stdout=subprocess.DEVNULL, stderr=log)
            else:
                command = subprocess.run(args, shell=True, check=True, stderr=log)
    except subprocess.CalledProcessError as err:
        print(err)

