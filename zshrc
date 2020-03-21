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
alias kubeconfig='vim ~/.kube/config'
alias sshconfig='vim ~/.ssh/config'
alias tmuxconfig='vim ~/.tmux.conf'
alias vimconfig='vim ~/.vimrc'
alias zshconfig='vim ~/.zshrc'
alias zshload='source ~/.zshrc'
alias gop='git-open'
alias x='tmux new -s ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
alias xd='tmux detach -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'

# -- Config
eval $(thefuck --alias)
eval "$(rbenv init -)"
PROMPT=$PROMPT'$(kube_ps1) '
