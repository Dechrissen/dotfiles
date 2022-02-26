#!/bin/sh

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
supported=".bashrc|.nanorc|.alacritty.yml|xfce4|neofetch|micro"

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

echo "Finished copying files from local machine into dotfiles repo."
