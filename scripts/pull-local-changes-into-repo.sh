#!/bin/bash

# get parent path of script and cd to it so relative paths work properly
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# to ensure the for-loops include files starting with a .
shopt -s dotglob

# checks whether VALUE is in LIST (a string) where DELIMITER separates the items in LIST
function is_in_list() {
    LIST=$1
    DELIMITER=$2
    VALUE=$3
    echo $LIST | tr "$DELIMITER" '\n' | grep -F -q -x "$VALUE"
}

# set variables to use
dotfiles=~/dotfiles
home=~
config=~/.config

# pipe-delimited string of dotfiles that this script supports/maintains
supported=".bashrc|.nanorc|.alacritty.yml|xfce4|neofetch|micro|polybar|nitrogen|rofi|bspwm|sxhkd|dunst|picom.conf|Thunar"

# copy every file that is supported from ~/ into  ~/dotfiles/
for f in $home/*
do
    if is_in_list "$supported" "|" $(basename $f); then
        cp $f $dotfiles && echo $(basename $f) "copied into dotfiles"
    fi
done

# copy every file that is supported from ~/.config/ into ~/dotfiles/.config/
for f in $config/*
do
    if is_in_list "$supported" "|" $(basename $f); then
        cp -r $f $dotfiles/.config/ && echo $(basename $f) "copied into dotfiles"
    fi
done

# back up packages
dpkg --get-selections > ../packages.list

echo "Finished copying files from local machine into dotfiles repo."

# auto-commit the changes to my remote
cd $dotfiles && git add --all && git commit -m "Auto-update dotfiles repo with local changes." && git push origin master
