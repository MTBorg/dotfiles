#! /bin/bash
setxkbmap sv
xset -b #Mute the beeping sound

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
source $XDG_CONFIG_HOME/Xorg/.xdefaults
exec bspwm
