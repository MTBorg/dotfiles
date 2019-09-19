# Aliases
alias sudo="sudo " # This allows the use of sudo before aliases
alias h="history"
alias ll="ls -al"
if ! [ -x git ]; then 
	alias g="git"
fi
alias grep="grep --color=auto"
if ! [ -x bat ]; then # Use bat if installed
	alias cat="bat"
fi
alias sysstart="systemctl start"
alias sysstop="systemctl stop"
alias sysstatus="systemctl status"

#Activate vi mode with <Esc>:
set -o vi

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

# Pyenv
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# These two lines are necessary for pipenv to run under pyenv apparently
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Ranger
export RANGER_LOAD_DEFAULT_RC FALSE

# Start ssh-agent (i have no idea how this works)
# Taken from https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")" > /dev/null
fi

Z_PATH=$(dirname $BASH_SOURCE)/../z/z.sh
source $Z_PATH
