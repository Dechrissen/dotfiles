#!/bin/sh

# get parent path of script and cd to it so relative paths work properly
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# to ensure the for-loops include files starting with a .
shopt -s dotglob

# set variables to use
dotfiles=~/dotfiles
home=~
config=~/.config

# copy every file that is supported from  ~/dotfiles/ into ~
for f in $dotfiles/*
do
    if [[ $(basename $f) == ".config"  ]]; then
        echo "Skipping .config"
    else
        cp $f $home && echo $(basename $f) "copied into ~/"
    fi
done

# copy every file that is supported from ~/dotfiles/.config/ into ~/.config/
for f in $dotfiles/.config/*
do
    cp -r $f $config && echo $(basename $f) "copied into ~/.config/"
done

echo "Finished copying dotfiles into ~/"

echo "Installing packages..."
yay -S --noconfirm - < ../packages.list

echo "Installation complete. Have a nice day!"
