# =========================================================
# Keybindings
# =========================================================

# Cursor shape per vi mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# Enable system clipboard integration
# In Normal mode: 'y' to copy selection to system clipboard, 'p' or 'gp' to paste.
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# Edit the current command line in $VISUAL/$EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line

# zsh-vi-mode resets all bindings on init, so custom bindings
# must be registered via this hook to survive.
zvm_after_init() {
  # Normal mode v -> edit current command in nvim
  zvm_bindkey vicmd 'v' edit-command-line

  # Word navigation
  # Note: Option+Arrow is preferred on macOS to avoid Mission Control conflicts.
  local keymap
  for keymap in viins vicmd; do
    # Ctrl+Right variations
    zvm_bindkey $keymap '^[[1;5C' forward-word
    zvm_bindkey $keymap '^[[5C'   forward-word
    zvm_bindkey $keymap '^Oc'     forward-word

    # Ctrl+Left variations
    zvm_bindkey $keymap '^[[1;5D' backward-word
    zvm_bindkey $keymap '^[[5D'   backward-word
    zvm_bindkey $keymap '^Od'     backward-word

    # Option+Right / Option+Left (standard macOS word movement)
    zvm_bindkey $keymap '^[f'     forward-word
    zvm_bindkey $keymap '^[b'     backward-word
    zvm_bindkey $keymap '^[[1;3C' forward-word
    zvm_bindkey $keymap '^[[1;3D' backward-word
  done

  # Option + Backspace -> Delete word backward
  # IMPORTANT macOS CONFIGURATION:
  # - iTerm2: Settings -> Profiles -> Keys -> General -> Left Option = "Esc+"
  # - Terminal.app: Settings -> Profiles -> Keyboard -> "Use Option as Meta Key"
  zvm_bindkey viins '^[^?' backward-kill-word
  zvm_bindkey viins '^[^H' backward-kill-word

  # Right Arrow -> Accept autosuggestion in insert mode
  zvm_bindkey viins '^[[C' autosuggest-accept

  # Left/Right Arrow -> character movement in normal mode (survive zvm reset)
  zvm_bindkey vicmd '^[[D' vi-backward-char
  zvm_bindkey vicmd '^[[C' vi-forward-char
  zvm_bindkey vicmd '^[OD' vi-backward-char
  zvm_bindkey vicmd '^[OC' vi-forward-char

  # Ctrl+R -> fzf history search (unified UI across modes)
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey vicmd '^R' fzf-history-widget

  # Bind '/' in Normal mode to fzf history search for a better list UI
  zvm_bindkey vicmd '/' fzf-history-widget

  # Ctrl+F -> fzf file picker (no hidden files)
  zvm_bindkey viins '^F' _fzf_file_no_hidden
  zvm_bindkey vicmd '^F' _fzf_file_no_hidden

  # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
  zvm_bindkey viins '^\' autosuggest-toggle
  zvm_bindkey vicmd '^\' autosuggest-toggle

  # Up/Down -> history search by substring (^[[A/^[[B are up/down arrow escape codes)
  zvm_bindkey viins '^[[A' history-substring-search-up
  zvm_bindkey vicmd '^[[A' history-substring-search-up
  zvm_bindkey viins '^[[B' history-substring-search-down
  zvm_bindkey vicmd '^[[B' history-substring-search-down

  # Ensure Tab triggers completion correctly
  zvm_bindkey viins '^I' expand-or-complete
  zvm_bindkey vicmd '^I' expand-or-complete

  # Ensure plugins are running and wrapping the correct widgets
  if [[ -f "${ZPLUGINDIR}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "${ZPLUGINDIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
  if [[ -f "${ZPLUGINDIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]]; then
    source "${ZPLUGINDIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
  fi
}
