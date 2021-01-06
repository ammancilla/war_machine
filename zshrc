# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# -- Theme
ZSH_THEME="dracula"

# -- Plugins
plugins=(git gh kube-ps1)

# -- Initialize
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
export WAR_MACHINE=$HOME/.war_machine

# -- Aliases
alias gfp='git push -f'
alias gog="$GOPATH/bin/g";
alias gop='git-open'
alias grh='git reset --hard'

alias kubeconfig='vim ~/.kube/config'
alias sshconfig='vim ~/.ssh/config'
alias tmuxconfig='vim ~/.tmux.conf'
alias vimconfig='vim ~/.vimrc'
alias zshconfig='vim ~/.zshrc'
alias zshload='source ~/.zshrc'

alias x='tmux new -s ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
alias xd='tmux detach -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'

alias k='kubectl'
alias ka='kubectl apply -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kex='kubectl exec -ti'

# -- Config
eval "$(rbenv init -)"

eval $(thefuck --alias)

kubeps1=$(which kube_ps1)
if [ $? -eq 0 ] ; then
  PROMPT=$PROMPT'$(kube_ps1) '
fi
