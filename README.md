# dotfiles

The various dotfiles and configs I use on my Linux systems.

## Scripts

The `scripts` directory contains shell scripts that you can adapt and use on your own system if you wish to use my dotfiles.

`pull-local-changes-into-repo.sh` - Pulls local changes to dotfiles on your system into this dotfiles repo (if cloned to your machine) and subsequently updates the remote.
_Important_: Do not run this script as root/with `sudo`; the scripts depends on being the user, so `~` corresponds to user's home directory.

`install.sh` - Installs the contents of the repository onto your system.

## TODO

- include check in install.sh for installed fonts in /usr/share/fonts/TTF
- install list of fonts and automatically move to /usr/share/fonts/TTF
- list of fonts can be stored in fonts.list in this dir (Roboto Mono, Fira Code, Hack, Mononoki, etc.)
