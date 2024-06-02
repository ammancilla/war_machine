# -- Exports
export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PROJECTS=$HOME/src
export WAR_MACHINE=$HOME/.war_machine
# - github repo switcher (jdx/gh)
export GH_BASE_DIR=$PROJECTS


# -- Theme
ZSH_THEME="dracula"

# -- Plugins
plugins=(git gh asdf zsh-autosuggestions zsh-syntax-highlighting)

# -- Initialize
source $ZSH/oh-my-zsh.sh
source $WAR_MACHINE/helpers.sh

# -- Aliases
alias gfp='git push -f'
alias gop='git-open'
alias grh='git reset --hard'
alias gdst='git diff --staged'

alias zshload='source ~/.zshrc'
alias zshconfig='vim ~/.zshrc'
alias vimconfig='vim ~/.vimrc'
alias gitconfig='vim ~/.gitconfig'
alias sshconfig='vim ~/.ssh/config'
alias asdfconfig='vim ~/.tool-versions'
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

alias bx='bundle exec'

alias ycminstall='~/.vim/plugged/YouCompleteMe/install.py'

# -- Configuration
eval $(thefuck --alias)
eval $(starship init zsh)
