#!/usr/bin/env python3
import subprocess
import os
import git
import shutil


def License():
    print("""
    ARCHSYSTEMCONFIGTOOL Copyright (C) 2022 Michael Petersen
    This program comes with ABSOLUTELY NO WARRANTY
    This is free software, and you are welcome to redistribute it
    under certain conditions
    """)


def process(cmd, silent=False):
    try:
        cmdsplit = cmd.split()
        with open('log.txt', 'w') as log:
            if(silent):
                task = subprocess.run(
                    cmdsplit, check=True, stdout=subprocess.DEVNULL, stderr=log)
            else:
                task = subprocess.run(cmdsplit, check=True, stderr=log)
    except subprocess.CalledProcessError as err:
        print(err)
    except Exception as err:
        print("Unhandled Error Detected, Please contact development@michaelpetersen.co or develop error handling yourself.")
        print(err)
    if (os.stat('log.txt').st_size == 0):
        os.remove('log.txt')

def clone(repository, path):
    if os.path.isdir(path):
        shutil.rmtree(path)
    git.Repo.clone_from(repository, path)


def build(path):
    dir = os.getcwd()
    os.chdir(path)
    build = subprocess.Popen(["makepkg", '-sri'], preexec_fn=demote(1000, 1000))
    build.wait()
    os.chdir(dir)


def demote(user_uid, user_gid):
    os.setuid(user_uid)
    os.setgid(user_gid)
