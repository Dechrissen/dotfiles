# dotfiles

The various dotfiles and configs I use on my (Debian-based) Linux systems.

## Scripts

The `scripts` directory contains shell scripts that you can adapt and use on your own system if you wish to use my dotfiles (comment out anything that doesn't apply to you, like my home server share mounting).

1. `install.sh` - Installs the contents of the repository onto your system. (needs root priveleges; run with `sudo`)
2. `pull-local-changes-into-repo.sh` - Pulls local changes to dotfiles on your system into this dotfiles repo (if cloned to your machine) and subsequently updates the remote with those changes. (run **without** `sudo`; this script depends on being the user, so `~` corresponds to the user's home directory)


## TODO
- include check in install.sh for installed fonts in /usr/share/fonts/TTF
- install list of fonts and automatically move to /usr/share/fonts/TTF
- list of fonts can be stored in fonts.list in this dir (Roboto Mono, Fira Code, Hack, Mononoki, etc.)
