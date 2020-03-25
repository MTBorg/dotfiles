export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export TERMINAL=alacritty

export GPG_TTY=$(tty)

[ -f $HOME/dev.env ] && source $HOME/dev.env

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
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
