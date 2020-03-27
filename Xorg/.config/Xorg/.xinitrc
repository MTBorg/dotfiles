#! /bin/bash
exec bspwm
exec setxkbmap sv
exec xset -b #Mute the beeping sound

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
