from helpers import build, clone

clone('https://aur.archlinux.org/yay-bin.git', '/tmp/yay')
build('/tmp/yay')