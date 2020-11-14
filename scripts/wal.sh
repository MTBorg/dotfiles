# Switch to the next wallpaper
waln() {
	wal -i ~/Pictures/wallpapers --iterative;
}

# Select a picture to use with wal using fzf
fzwal(){
	ls ~/Pictures/wallpapers | \
	fzf --bind "enter:execute(wal -i ~/Pictures/wallpapers/{})"
}
