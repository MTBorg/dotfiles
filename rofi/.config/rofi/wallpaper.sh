echo -en "\0keep-selection\x1ftrue\n"

ls ~/Pictures/wallpapers

if [ "$@" ]; then wal -a 92 -i ~/Pictures/wallpapers/$@ > /dev/null; fi
