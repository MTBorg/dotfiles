alias sudo="sudo " # This allows the use of sudo before aliases
alias h="history"
alias ll="ls -al --color=auto"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
if ! [ -x git ]; then 
	alias g="git"
fi
alias grep="grep --color=auto"
if ! [ -x bat ]; then # Use bat if installed
	alias cat="bat"
fi
alias sysstart="systemctl start"
alias sysstop="systemctl stop"
alias sysrestart="systemctl restart"
alias sysstatus="systemctl status"
alias sysenable="systemctl enable"
alias sysdisable="systemctl disable"
if ! [ -x docker ]; then
	alias d="docker"
fi
if ! [ -x docker-compose ]; then
	alias dc="docker-compose"
fi

# Arch Linux specific aliases
if [ -f "/etc/arch-release" ]; then
	alias p="pacman"
fi
