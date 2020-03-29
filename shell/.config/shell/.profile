export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export TERMINAL=alacritty

export GPG_TTY=$(tty)

# Tell programs to use XDG directories
export _Z_DATA=$XDG_DATA_HOME/z
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export MYSQL_HISTFILE=$XDG_DATA_HOME/mysql_history
export PSQL_HISTORY=$XDG_CACHE_HOME/pg/psql_history
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export LESSHISTFILE=- #Don't use a history file
export PYLINTHOME=$XDG_CACHE_HOME/pylint
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

DEV_FILE=$XDG_CONFIG_HOME/.dev.env
[ -f $DEV_FILE ] && source $DEV_FILE

# Use vim as editor when running command fc
export FCEDIT=nvim

# Use vim as standard editor
export EDITOR=nvim

# Start ssh-agent (i have no idea how this works)
# Taken from https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")" > /dev/null
fi

# Source pyenv
if [[ "type pyenv" ]];then
	export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Start xorg
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then	
	exec startx $XDG_CONFIG_HOME/Xorg/.xinitrc
fi
