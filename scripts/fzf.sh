#!/bin/sh

# Functions utilizing fzf

# Edit files in $XDG_CONFIG_HOME using input from fzf
function fzced() {
	find -L $XDG_CONFIG_HOME -type f | fzf | xargs --no-run-if-empty $EDITOR
}

# Edit file using input from fzf (relative to cwd)
function fzed() {
	find -L -type f 2>&1 | grep -v "Permission denied" | fzf | \
		xargs --no-run-if-empty $EDITOR
}

# Use cd with input from fzf
function fzcd() {
	cd $(find / -type d 2>&1 | grep -v "Permission denied" | fzf)
}

# Use ls with input from fzf
function fzls() {
	find -type d | fzf | xargs ls
}

# Use cat with input from fzf
function fzcat() {
	find -L -type f 2>&1 | grep -v "Permission denied" | fzf | \
		xargs --no-run-if-empty cat
}

# Use bat with input from fzf
function fzbat() {
	find -L -type f 2>&1 | grep -v "Permission denied" | fzf | \
		xargs --no-run-if-empty bat
}
