# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# -- Theme
ZSH_THEME="dracula"

# -- Plugins
plugins=(git kube-ps1 gh)

# -- Initialize
source $ZSH/oh-my-zsh.sh

#
# User configuration
#

# -- Exports
export LANG=en_US.UTF-8
export PATH=/urs/local/bin/vim:$PATH
export LC_ALL=en_US.UTF-8
export WAR_MACHINE=$HOME/.war_machine
export KUBE_PS1_SEPARATOR=""

# -- Aliases
alias gfp='git push -f'
alias gop='git-open'
alias grh='git reset --hard'

alias zshload='source ~/.zshrc'
alias zshconfig='vim ~/.zshrc'
alias vimconfig='vim ~/.vimrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias kubeconfig='vim ~/.kube/config'
alias tmuxconfig='vim ~/.tmux.conf'

alias x='tmux new -s ${PWD##*/}'
alias xa='tmux attach -t ${PWD##*/}'
alias xd='tmux detach -s ${PWD##*/}'
alias xk='tmux kill-session -t ${PWD##*/}'

alias k='kubectl'
alias ka='kubectl apply -f'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kex='kubectl exec -ti'

#
# Helper functions
#
source $WAR_MACHINE/helpers/fgco.sh

#
# Apps configuration
#
eval $(thefuck --alias)

kubeps1=$(which kube_ps1)
if [ $? -eq 0 ] ; then
  PROMPT=$PROMPT'$(kube_ps1) '
fi
