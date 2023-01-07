#!/usr/bin/env sh

#
# Dinamically change between git branches using fzf.
#

fgco() {
  git branch -vv | fzf +m --query="$1" | awk '{print $1}' | xargs git checkout
}
