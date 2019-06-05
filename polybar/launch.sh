#!/bin/bash

#Terminate alread running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar  > /dev/null; do sleep 1; done

# Launch Polybar, using default config location
polybar -c ~/Configs/polybar/config mybar &
