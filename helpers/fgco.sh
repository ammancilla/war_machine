#!/usr/bin/env sh

#
# Dinamically change between git branches using fzf.
#

fgco() {
  local branches branch
	branches=$(git branch -vv) &&
	branch=$(echo "$branches" | fzf +m --query="$1") &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
