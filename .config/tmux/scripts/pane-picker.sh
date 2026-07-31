#!/usr/bin/env bash
# Grouped pane picker: session > window > pane
set -euo pipefail

tmux list-panes -a -F '#{session_name}	#{window_index}	#{window_name}	#{pane_index}	#{pane_current_command}	#{pane_current_path}' \
  | awk -F'\t' '
      BEGIN { s=""; w="" }
      {
        if ($1 != s) { printf "\033[1;36m▼ %s\033[0m\n", $1; s=$1; w="" }
        if ($2 != w) { printf "  \033[1;33m● [%s] %s\033[0m\n", $2, $3; w=$2 }
        printf "    \033[32m%s:%s.%s\033[0m  %s  \033[90m%s\033[0m\n", $1, $2, $4, $5, $6
      }' \
  | fzf --ansi --reverse \
        --header='Jump to pane (session > window > pane)' \
        --prompt='pane> ' \
  | grep -oE '[A-Za-z0-9_.-]+:[0-9]+\.[0-9]+' \
  | head -1 \
  | xargs -r -I {} sh -c 'tmux switch-client -t "{}" && tmux select-pane -t "{}"'
