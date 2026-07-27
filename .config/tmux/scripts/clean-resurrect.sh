#!/usr/bin/env bash
set -e

# Default resurrect directory logic (matches tmux-resurrect helpers.sh)
if [ -d "$HOME/.tmux/resurrect" ]; then
    RESURRECT_DIR="$HOME/.tmux/resurrect"
else
    RESURRECT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect"
fi

# Override with argument if provided (e.g., via post-save hook)
if [ -n "$1" ] && [ -d "$1" ]; then
    RESURRECT_DIR="$1"
fi

if [ -d "$RESURRECT_DIR" ]; then
    # Keep only the most 2 latest save point files (tmux_resurrect_*.txt)
    ls -t "$RESURRECT_DIR"/tmux_resurrect_*.txt 2>/dev/null | tail -n +3 | xargs rm -f 2>/dev/null || true
fi

# Send notification on save success
if command -v osascript >/dev/null 2>&1; then
    osascript -e 'display notification "Tmux environment & pane contents saved successfully!" with title "tmux-resurrect" subtitle "Backup Complete"' 2>/dev/null || true
fi

if command -v tmux >/dev/null 2>&1; then
    tmux display-message "tmux-resurrect: Environment saved successfully! (retained 2 latest backups)" 2>/dev/null || true
fi
