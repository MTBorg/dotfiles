alias h="history"
alias ll="ls -al"

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

source ~/.config/z/z.sh
