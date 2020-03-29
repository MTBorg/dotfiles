source $XDG_CONFIG_HOME/aliases/.aliases.sh

# Check window size after each command
shopt -s checkwinsize

# Append to history file, don't overwrite
shopt -s histappend

#Activate vi mode with <Esc>:
set -o vi


# Place in history file in cache folder
export HISTFILE=$HOME/.cache/.bash_history

# Color the command prompt
export PS1="\e[0;32m[\u@\h \W]$ \e[m"

# Color man pages
export LESS_TERMCAP_md=$'\e[01;32m' # Bold start
export LESS_TERMCAP_me=$'\e[0m' # Bold end
export LESS_TERMCAP_so=$'\e[01;44;33m' # Standout-mode start
export LESS_TERMCAP_se=$'\e[0m' # Standout-mode end
export LESS_TERMCAP_us=$'\e[01;32m' # Underline start
export LESS_TERMCAP_ue=$'\e[0m' # Underline end

# These two lines are necessary for pipenv to run under pyenv apparently
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Ranger
export RANGER_LOAD_DEFAULT_RC FALSE

# Place z's data file in cache folder
export _Z_DATA=$HOME/.cache/.z

# Source z
Z_PATH=~/dotfiles/z/z.sh
source $Z_PATH
