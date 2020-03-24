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
export GOPATH=$HOME/go
export GOROOT=$HOME/.go
export KUBE_PS1_SEPARATOR=""
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$GOPATH/bin:$PATH
export PATH=/urs/local/bin/vim:$PATH
export WAR_MACHINE=/Users/apolonio/src/github.com/ammancilla/war_machine

# -- Aliases
alias gog="$GOPATH/bin/g";
alias gop='git-open'
alias kubeconfig='vim ~/.kube/config'
alias sshconfig='vim ~/.ssh/config'
alias tmuxconfig='vim ~/.tmux.conf'
alias vimconfig='vim ~/.vimrc'
alias x='tmux new -s ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
alias xd='tmux detach -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'
alias zshconfig='vim ~/.zshrc'
alias zshload='source ~/.zshrc'

# -- Config
eval "$(rbenv init -)"
eval $(thefuck --alias)
PROMPT=$PROMPT'$(kube_ps1) ' # Must be kept at the end
