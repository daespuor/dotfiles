#!/usr/bin/env bash

languages=$(echo "golang typescript javascript rust c" | tr " " "\n")
core_utils=$(echo "find awk grep xargs sed" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIMME YOUR QUERY:" query

if echo "$languages" | grep -qs "$selected"; then
    tmux split-window -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less" 
else
    tmux split-window -h bash -c "curl cht.sh/$selected~$query | less"
fi