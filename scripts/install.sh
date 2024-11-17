#!/bin/bash

# Install script for dotfiles, packages, mounting, etc.

# Run this script with sudo!

# get parent path of script and cd to it so relative paths work properly
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# to ensure the for-loops include files starting with a .
shopt -s dotglob

# set variables to use
dotfiles=/home/$SUDO_USER/dotfiles
home=/home/$SUDO_USER
config=/home/$SUDO_USER/.config
bill=/mnt/bill
SMBCREDENTIALS=/home/$SUDO_USER/.smbcredentials

# copy every file that is supported from  ~/dotfiles/ into ~
for f in $dotfiles/*
do
    if [[ $(basename $f) == ".git"  ]]; then
         echo "Skipping directory .git"
    elif [[ $(basename $f) == "scripts"  ]]; then
         echo "Skipping directory scripts"
    elif [[ $(basename $f) == ".config"  ]]; then
        echo "Skipping directory .config"
    elif [[ $(basename $f) == "conf"  ]]; then
        echo "Skipping directory conf"
    elif [[ $(basename $f) == "README.md" ]]; then
        echo "Skipping file README.md"
    elif [[ $(basename $f) == "packages.list" ]]; then
        echo "Skipping file packages.list"
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

# lightdm stuff
apt-get -y install lightdm lightdm-gtk-greeter
cp $dotfiles/conf/lightdm.conf /etc/lightdm/lightdm.conf
# restart lightdm
systemctl restart lightdm
echo "Finished setting up lightdm"

# install packages from packages.list
# this needs to run before the following fstab section, as that depends on cifs-utils package
echo "Installing packages..."
dpkg --set-selections < ../packages.list
apt-get update
apt-get -u dselect-upgrade

# append server entry to fstab, and mount all
# but first check if the mount point does NOT already exist, and proceed if so
if [ ! -d "$bill" ]; then
    # then check to make sure .smbcredentials file exists
    if [ -f "$SMBCREDENTIALS" ]; then
        echo ".smbcredentials file found."
        echo "Creating mount point..."
        mkdir "$bill"
        server_entry="//bill.home/derek /mnt/bill   cifs    credentials=/home/derek/.smbcredentials,iocharset=utf8,noserverino,noperm,vers=3.0  0   0"
        echo "Appending server entry to fstab..."
        echo "$server_entry" >> /etc/fstab
        echo "Reloading daemons..."
        systemctl daemon-reload
        echo "Mounting..."
        mount -a
    else
        echo "WARN: .smbcredentials file does not exist in $home; please create it and then re-run this script!"
    fi
fi

# make scripts executable if necessary
chmod +x $home/.config/polybar/launch.sh

# done
echo ""
echo "Installation complete. Have a nice day!"
