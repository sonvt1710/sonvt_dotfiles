#!/usr/bin/env bash
# Restore personal dotfiles, zsh/tmux, and iTerm2 preferences on a new Mac.
# Run: bash ~/projects/scripts/setup-dotfiles-config.sh
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-git@github.com:sonvt1710/sonvt_dotfiles.git}"
DOTFILES_GIT_DIR="${DOTFILES_GIT_DIR:-$HOME/.config/.git}"
DOTFILES_WORK_TREE="${DOTFILES_WORK_TREE:-$HOME}"
ITERM_PLIST="$HOME/.config/iterm2/com.googlecode.iterm2.plist"

info() { printf '[info] %s\n' "$*"; }
ok() { printf '[ok] %s\n' "$*"; }
warn() { printf '[warn] %s\n' "$*" >&2; }

dotfiles_git() {
  git --git-dir="$DOTFILES_GIT_DIR" --work-tree="$DOTFILES_WORK_TREE" "$@"
}

install_dotfiles_repo() {
  mkdir -p "$HOME/.config"

  if [ -d "$DOTFILES_GIT_DIR" ]; then
    ok "dotfiles git dir exists: $DOTFILES_GIT_DIR"
    dotfiles_git fetch origin main
    return
  fi

  info "Cloning dotfiles repo into $DOTFILES_GIT_DIR"
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT

  git clone --no-checkout --separate-git-dir "$DOTFILES_GIT_DIR" "$DOTFILES_REPO" "$tmp_dir"
  git --git-dir="$DOTFILES_GIT_DIR" config core.worktree "$DOTFILES_WORK_TREE"
  dotfiles_git fetch origin main
}

checkout_dotfiles() {
  info "Checking out zsh, tmux, iTerm2, and setup script files"
  dotfiles_git checkout origin/main -- \
    .gitignore \
    .config/zsh \
    .config/tmux \
    .config/iterm2 \
    projects/scripts/setup-dotfiles-config.sh \
    projects/scripts/export-dotfiles-config.sh
}

install_zsh_entrypoint() {
  if [ ! -f "$HOME/.zshenv" ]; then
    info "Creating ~/.zshenv to load zsh from ~/.config/zsh"
    cat > "$HOME/.zshenv" <<'EOF'
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
EOF
  else
    ok "~/.zshenv exists"
  fi
}

install_iterm2_preferences() {
  if [ ! -f "$ITERM_PLIST" ]; then
    warn "iTerm2 plist not found: $ITERM_PLIST"
    return
  fi

  info "Importing iTerm2 preferences from $ITERM_PLIST"
  defaults import com.googlecode.iterm2 "$ITERM_PLIST"
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.config/iterm2"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  ok "iTerm2 preferences installed; restart iTerm2 to reload them"
}

validate_config_files() {
  if command -v zsh >/dev/null 2>&1; then
    zsh -n "$HOME/.config/zsh/.zshrc"
    ok "zsh config syntax is valid"
  else
    warn "zsh not found; skipped zsh syntax validation"
  fi

  if command -v tmux >/dev/null 2>&1; then
    tmux source-file -n "$HOME/.config/tmux/tmux.conf.local"
    ok "tmux config syntax is valid"
  else
    warn "tmux not found; skipped tmux syntax validation"
  fi
}

main() {
  install_dotfiles_repo
  checkout_dotfiles
  install_zsh_entrypoint
  install_iterm2_preferences
  validate_config_files
  ok "dotfiles setup complete"
}

main "$@"
