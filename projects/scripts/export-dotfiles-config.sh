#!/usr/bin/env bash
# Capture current machine preferences into the tracked dotfiles files.
# Run: bash ~/projects/scripts/export-dotfiles-config.sh
set -euo pipefail

DOTFILES_GIT_DIR="${DOTFILES_GIT_DIR:-$HOME/.config/.git}"
DOTFILES_WORK_TREE="${DOTFILES_WORK_TREE:-$HOME}"
ITERM_PLIST="$HOME/.config/iterm2/com.googlecode.iterm2.plist"

info() { printf '[info] %s\n' "$*"; }
ok() { printf '[ok] %s\n' "$*"; }
warn() { printf '[warn] %s\n' "$*" >&2; }

dotfiles_git() {
  git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$DOTFILES_WORK_TREE" "$@"
}

export_iterm2_preferences() {
  mkdir -p "$(dirname "$ITERM_PLIST")"
  info "Exporting current iTerm2 preferences to $ITERM_PLIST"
  defaults export com.googlecode.iterm2 "$ITERM_PLIST"
  plutil -lint "$ITERM_PLIST" >/dev/null
  ok "iTerm2 preferences exported"
}

validate_config_files() {
  zsh -n "$HOME/.config/zsh/.zshrc"
  tmux source-file -n "$HOME/.config/tmux/tmux.conf.local"
  ok "zsh and tmux configs are valid"
}

show_dotfiles_status() {
  if [ -d "$DOTFILES_GIT_DIR" ]; then
    info "Dotfiles changes:"
    dotfiles_git status --short .config/iterm2 .config/zsh .config/tmux projects/scripts
  else
    warn "dotfiles git dir not found: $DOTFILES_GIT_DIR"
  fi
}

main() {
  export_iterm2_preferences
  validate_config_files
  show_dotfiles_status
}

main "$@"
