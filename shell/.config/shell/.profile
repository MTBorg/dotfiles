export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export TERMINAL=alacritty

export GPG_TTY=$(tty)

# This tells fzf to incude hidden files
export FZF_DEFAULT_COMMAND="find -type f"

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
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export STACK_ROOT=$XDG_DATA_HOME/stack
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node_repl_history
export PULSE_COOKIE=$XDG_CONFIG_HOME/pulse/pulse-cookie
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

DEVICE_FILE=$XDG_CONFIG_HOME/.device.profile.env
[ -f $DEVICE_FILE ] && source $DEVICE_FILE

# Use vim as editor when running command fc
export FCEDIT=nvim

# Use vim as standard editor
export EDITOR=nvim

# Use neovim as pager for man
export MANPAGER="nvim -c 'set ft=man' -"

export PATH=$PATH:~/.local/bin/scripts

# This is needed for android studio
export _JAVA_AWT_WM_NONREPARENTING=1

# Start ssh-agent (i have no idea how this works)
# Taken from https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")" > /dev/null
fi

# Start xorg
if command -v systemctl && systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then	
	exec startx $XDG_CONFIG_HOME/Xorg/.xinitrc
fi

# source pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
