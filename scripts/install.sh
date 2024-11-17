#!/bin/bash

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

# install packages from packages.list
# this needs to run before the following fstab section, as that depends on cifs-utils package
echo "Installing packages..."
sudo dpkg --set-selections < ../packages.list
sudo apt-get update
sudo apt-get -u dselect-upgrade

# append server entry to fstab, and mount all
echo "Creating mount point..."
mkdir -p /mnt/bill
server_entry="//bill.home/derek /mnt/bill   cifs    credentials=/home/derek/.smbcredentials,iocharset=utf8,noserverino,noperm,vers=3.0  0   0"
echo "Appending server entry to fstab..."
sudo echo "$server_entry" >> /etc/fstab
echo "Reloading daemons..."
sudo systemctl daemon-reload
echo "Mounting..."
sudo mount -a

# done
echo "Installation complete. Have a nice day!"
