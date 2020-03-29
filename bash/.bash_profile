#
# ~/.bash_profile
#

[[ -f $HOME/.bashrc ]] && . ~/.bashrc
[[ -f $HOME/.config/shell/.profile ]] && . ~/.config/shell/.profile

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then	
	exec startx
fi
