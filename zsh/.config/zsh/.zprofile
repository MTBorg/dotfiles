source ~/.config/shell/.profile

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then	
	exec startx $XDG_CONFIG_HOME/Xorg/.xinitrc
fi
