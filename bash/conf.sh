alias h="history"
alias ll="ls -al"
alias gst="git status"
alias grep="grep --color=auto"

# Arch Linux specific keybindings
if [ -f "/etc/arch-release" ]; then
	alias p="pacman"
fi

# Use vim as editor when running command fc
export FCEDIT=vim

# Color the command prompt
export PS1="\e[0;32m[\u@\h \W]$ \e[m"

# Use vim as standard editor
export EDITOR="vim"

# Color man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

source ~/.config/z/z.sh
