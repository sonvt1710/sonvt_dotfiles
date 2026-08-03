#!/usr/bin/env bash
# Popup tmux command prompt. Reads a tmux command line and executes it.
# ESC closes the popup (via readline: ESC clears line + accepts empty input).
set -uo pipefail

# History file for readline (up-arrow recall)
histfile="${TMUX_CMD_HISTFILE:-$HOME/.cache/tmux-cmd-popup.history}"
mkdir -p "$(dirname "$histfile")"
touch "$histfile"

# Load history into readline
if [ -s "$histfile" ]; then
  history -r "$histfile" 2>/dev/null || true
fi

# ESC → clear line + submit (empty submit = exit below)
export INPUTRC="$HOME/.config/tmux/scripts/inputrc"

read -re -p ":" cmd || exit 0
[ -z "$cmd" ] && exit 0

# Append to history
history -s "$cmd"
history -w "$histfile" 2>/dev/null || true

# Run through tmux. eval so quoted args work like real command-prompt.
if ! eval "tmux $cmd" 2>/tmp/tmux-cmd-popup.err; then
  echo
  echo "Error:"
  cat /tmp/tmux-cmd-popup.err
  echo
  read -rp "Press enter to close..." _
fi
