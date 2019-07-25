alias h="history"
alias ll="ls -al"

# Arch Linux specific keybindings
if [ -f "/etc/arch-release" ]; then
	alias p="pacman"
fi

# Use vim as editor when running command fc
FCEDIT=vim

# Color the command prompt
PS1="\e[0;32m[\u@\h \W]$ \e[m"

source ~/.config/z/z.sh
