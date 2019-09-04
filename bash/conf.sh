# Aliases
alias sudo="sudo " # This allows the use of sudo before aliases
alias h="history"
alias ll="ls -al"
alias gst="git status"
alias grep="grep --color=auto"
if ! [ -x bat ]; then # Use bat if installed
	alias cat="bat"
fi

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
export LESS_TERMCAP_md=$'\e[01;32m' # Bold start
export LESS_TERMCAP_me=$'\e[0m' # Bold end
export LESS_TERMCAP_so=$'\e[01;44;33m' # Standout-mode start
export LESS_TERMCAP_se=$'\e[0m' # Standout-mode end
export LESS_TERMCAP_us=$'\e[01;32m' # Underline start
export LESS_TERMCAP_ue=$'\e[0m' # Underline end

Z_PATH=$(dirname $BASH_SOURCE)/../z/z.sh
source $Z_PATH
