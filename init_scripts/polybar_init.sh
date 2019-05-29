# Copies the config files to .config and the spotify status script to the home folder.
eval "mkdir -p ~/.config/polybar/ &&
			cp -t ~/.config/polybar/ polybar/config polybar/launch.sh &&
			cp polybar/polybar-spotify/spotify_status.py ~"
