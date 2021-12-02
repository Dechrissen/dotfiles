# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
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
export PS1="[\[$(tput bold)\]\[\033[38;5;9m\]\u\[$(tput sgr0)\]@\[$(tput bold)\]\[\033[38;5;10m\]\h\[$(tput sgr0)\] \[$(tput bold)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]] -> \[$(tput sgr0)\]"

alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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


# Python alias
alias python=python3
alias pip=pip3

alias pokequiz='python -m pokequiz'

# SSH aliases
alias banjovps='ssh -p 801 dechrissen@banjospeedruns.com'
alias vps='ssh derek@derekandersen.net'

alias neofetch="clear && neofetch --kernel_shorthand on --de_version on --gtk2 "off" --gtk3 "off" --disk_show '/dev/sda3' --disk_subtitle name --disk_percent on --cpu_cores "physical" --cpu_display "barinfo"  --cpu_temp "C" --memory_percent "on" --memory_display "barinfo" --bar_char '=' '-' --bar_border "on" --bar_colors 6 8 --ascii_distro "Arch" --color_blocks "off" --os_arch on --refresh_rate on "

# up and down arrow keys search history related to current partial input
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


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
neofetch
# echo "$greet Today is $d."
# fortune | cowsay
echo ""

