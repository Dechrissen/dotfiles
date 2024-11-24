# ________     _______       _________
# ___  __ \    ___    |____________  /______________________________
# __  / / /    __  /| |_  __ \  __  /_  _ \_  ___/_  ___/  _ \_  __ \
# _  /_/ /     _  ___ |  / / / /_/ / /  __/  /   _(__  )/  __/  / / /
# /_____/      /_/  |_/_/ /_/\__,_/  \___//_/    /____/ \___//_/ /_/
#
# Derek Andersen
# https://github.com/Dechrissen
# https://derekandersen.net
#
# My personal .bashrc (for Debian-based systems)

# TESSERACT path
export TESSERACT_PATH="/usr/bin/tesseract"
export TESSDATA_PREFIX="/usr/share/tesseract-ocr/5/tessdata/"

# PATH
# what to add to path
NPATH="$HOME/.local/bin"

# add it only if required
case ":${PATH}:" in
  *:${NPATH}:*) ;;
  *) PATH=${PATH}:$NPATH ;;
esac

export PATH

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# environment variables
export PROJECTS='/home/derek/projects'
export bashrc='/home/derek/.bashrc'
export SSH='/home/derek/.ssh'
export nanorc='/home/derek/.nanorc'

# prompt
source ~/dotfiles/.git-prompt.sh
export PS1="\[\033[31m\]\u\[$(tput sgr0)\]@\[\033[32m\]\h\[$(tput sgr0)\] \[\033[33m\]\w\[$(tput sgr0)\]\[\033[35m\]$(__git_ps1 " (%s)") \[$(tput sgr0)\]$\[$(tput sgr0)\] "


# ignore case for tab-completion
bind "set completion-ignore-case on"

# File aliases
alias ls='ls -a --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias la='ls -A'

# Python aliases
#alias python=python3
#alias pip=pip3

# SSH aliases
alias banjovps='ssh -i ~/.ssh/banjo -p 801 dechrissen@banjospeedruns.com'
alias vps='ssh -i ~/.ssh/vps -p 8012 derek@derekandersen.net'

# Other aliases
alias neofetch="clear && neofetch"
alias pushdots='cd ~/dotfiles && git pull && cd scripts && chmod u+x pull-local-changes-into-repo.sh && ./pull-local-changes-into-repo.sh'

# ThinkPad aliases
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage'"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# up and down arrow keys search history related to current partial input
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# fancy greeting
hour=$(date +"%H")
# if it is 2 to noon will say good morning
if [ $hour -ge 2 -a $hour -lt 12 ]
then
  greet="Good morning, Derek."
# if it is noon to 18 will say good afternoon
elif [ $hour -ge 12 -a $hour -lt 18 ] 
then
  greet="Good afternoon, Derek."
else # if it is 18 till 2
  greet="Good evening, Derek."
fi

d=$(date +"%B %d, %Y")

echo "$greet Today is $d."
fortune -sa | cowsay
echo ""

