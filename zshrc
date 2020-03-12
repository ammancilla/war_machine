# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# -- Theme
ZSH_THEME="dracula"

# -- Plugins
plugins=(git git-open gh kube-ps1)

# -- Initialize Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

#
# User Configuration
#
# -- Exports
export KUBE_PS1_SEPARATOR=""
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/urs/local/bin/vim:$PATH
export WAR_MACHINE=/Users/apolonio/src/github.com/ammancilla/war_machine

# -- Aliases
alias zshload='source ~/.zshrc'
alias zshconfig='vim ~/.zshrc'
alias vimconfig='vim ~/.vimrc'
alias tmuxconfig='vim ~/.tmux.conf'
alias x='tmux new -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
alias gop='git-open'

# -- Config
eval $(thefuck --alias)
eval "$(rbenv init -)"
PROMPT=$PROMPT'$(kube_ps1) '
