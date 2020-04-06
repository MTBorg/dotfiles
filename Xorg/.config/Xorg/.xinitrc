#! /bin/bash
setxkbmap sv
xset -b #Mute the beeping sound

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec bspwm
