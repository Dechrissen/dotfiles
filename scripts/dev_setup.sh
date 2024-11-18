#!/bin/bash

# variables
home=~
github_user=Dechrissen

# start ssh-agent so we can add our ssh identity and not have to keep entering passphrase for each clone
eval `ssh-agent -s`
# add the key (you will be prompted to enter the passphrase once)
ssh-add ~/.ssh/id_ed25519

# make dev directory and cd into it
mkdir -p $home/dev
cd $home/dev

# define list of repos to clone
declare -a repos=(
    website
    dechrissen.github.io
    notes
    tools
)

for repo in "${repos[@]}"; do
    echo "Cloning ${repo} ..."
    git clone git@github.com:${github_user}/${repo}.git
done
