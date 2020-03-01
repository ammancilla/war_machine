# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# -- Theme
ZSH_THEME="dracula"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# -- Plugins
plugins=(git gh kube-ps1)

# -- Initialize Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

#
# User Configuration
#
# -- Exports
export LANG=en_US.UTF-8
export PATH=/urs/local/bin/vim:$PATH
export WAR_MACHINE=/Users/apolonio/src/github.com/ammancilla/war_marchine

# -- Aliases
alias zshconfig='vim ~/.zshrc'
alias zshload='source ~/.zshrc'
alias tmuxconfig='vim ~/.tmux.conf'
alias x='tmux new -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
