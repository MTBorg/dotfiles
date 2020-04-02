# Base/base-devel
alias sudo="sudo " # This allows the use of sudo before aliases
alias s="sudo "
alias h="history"
alias ll="ls -al --color=auto"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias grep="grep --color=auto"
which bat > /dev/null && alias cat="bat" # Use bat if installed


# Systemctl
alias sysstart="systemctl start"
alias sysstop="systemctl stop"
alias sysrestart="systemctl restart"
alias sysstatus="systemctl status"
alias sysenable="systemctl enable"
alias sysdisable="systemctl disable"

# Docker
alias d="docker"
alias dc="docker-compose"

# Arch Linux specific aliases
if [ -f "/etc/arch-release" ]; then
	alias p="pacman"
fi

# Others
alias g="git"
alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/.tmux.conf"'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
