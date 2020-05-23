# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/arian/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="spaceship"

# Setting this with ZSH_THEME=random cause zsh to load from this variable instead of ~/.oh-my-zsh/themes/
# Check current random theme: echo $RANDOM_THEME
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# History in cache directory:
#HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="dd/mm/yyyy"

# Standard: ~/.oh-my-zsh/plugins/* - Custom: ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Overriding those provided by oh-my-zsh libs, plugins, and themes. Run `alias` to view all.
alias zshrc='nvim ~/.zshrc' # Quick access to the ~/.zshrc file
alias ohmyzsh="nano ~/.oh-my-zsh"
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
