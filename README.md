# dotfiles

The various dotfiles and configs I use on Linux systems (Arch-based).

## scripts

The `scripts` directory contains shell scripts that you can adapt and use on your own system if you wish to use my dotfiles.

`pull-local-changes-into-repo.sh` - Pulls local changes to dotfiles on your system into this dotfiles repo (if cloned to your machine).
Important: Do not run this script as root/with `sudo`; the scripts depends on being the user, so `~` corresponds to user's home directory.
