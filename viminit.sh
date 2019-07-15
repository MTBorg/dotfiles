git submodule update --init --recursive
rm -rf ~/.vimrc ~/.vim
ln -s -f ~/.config/.vimrc ~/.vimrc
ln -s -f ~/.config/.vim/ ~/.vim
