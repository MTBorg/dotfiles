export TERMINAL=alacritty

export GPG_TTY=$(tty)

[ -f $HOME/dev.env ] && source $HOME/dev.env

# Use vim as editor when running command fc
export FCEDIT=vim

# Use vim as standard editor
export EDITOR="vim"

# Start ssh-agent (i have no idea how this works)
# Taken from https://wiki.archlinux.org/index.php/SSH_keys#SSH_agents
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")" > /dev/null
fi
