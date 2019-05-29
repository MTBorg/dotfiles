eval "cp .vimrc ~ &&
	cd .vim &&
	git submodule update --init --recursive &&
	cp -r . ~/.vim"
