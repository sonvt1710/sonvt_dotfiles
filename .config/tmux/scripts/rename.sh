#!/usr/bin/env bash
# Popup rename for pane/window/session with current name prefilled.
# Usage: rename.sh {pane|window|session}
set -euo pipefail

kind="${1:-}"

case "$kind" in
  pane)
    current=$(tmux display-message -p '#T')
    label="Pane title"
    apply() { tmux select-pane -T "$1"; }
    ;;
  window)
    current=$(tmux display-message -p '#W')
    label="Window name"
    apply() { tmux rename-window "$1"; }
    ;;
  session)
    current=$(tmux display-message -p '#S')
    label="Session name"
    apply() { tmux rename-session "$1"; }
    ;;
  *)
    echo "usage: $0 {pane|window|session}" >&2
    exit 2
    ;;
esac

# ESC → clear line + submit (empty submit = exit without rename)
export INPUTRC="$HOME/.config/tmux/scripts/inputrc"

# -e enables readline; -i prefills with current value
read -rei "$current" -p "$label: " new || exit 0
[ -z "$new" ] && exit 0
apply "$new"
