#!/usr/bin/env sh

#
# Dinamically change between git branches using fzf.
#
fgco () {
  limit="${2:-100}"
  git branch --sort=-committerdate --format='%(refname:short)|%(committerdate:relative)|%(subject)' | \
    column -ts '|' | \
    head -n "$limit" | \
    fzf +m --query="$1" | \
    awk '{print $1}' | \
    xargs git checkout
}

fgco5 () { fgco "$1" 5; }
