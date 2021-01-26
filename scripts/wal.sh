# Select a picture to use with wal using fzf
fzwal(){
	ls ~/Pictures/wallpapers | \
	fzf --bind "enter:execute(wal -i ~/Pictures/wallpapers/{})"
}
