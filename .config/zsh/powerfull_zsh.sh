# Powerful but minimal zsh configuration
# Author: Radley E. Sidwell-Lewis
# GitHub: https://www.github.com/radleylewis/zsh
#
# Uses:
#   Plugins:      fast-syntax-highlighting, zsh-autosuggestions,
#                 zsh-history-substring-search, zsh-vi-mode
#   Prompt:       starship
#   Navigation:   zoxide, fzf, fd
#   CLI tools:    eza, bat, nvim, ripgrep
#   Node:         nvm

# =========================================================
# XDG Base Directories
# =========================================================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Ensure directories exist
mkdir -p "$XDG_CACHE_HOME/zsh"
mkdir -p "$XDG_STATE_HOME/zsh"

# =========================================================
# History
# =========================================================

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# =========================================================
# Smart directory navigation
# =========================================================

# Initialize zoxide
eval "$(zoxide init zsh)"

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit
compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump"

# High-quality "Awesome UI" completion settings
zstyle ':completion:*' menu select                             # MUST be enabled for fzf-tab to work
zstyle ':completion:*' verbose yes                             # Show details for matches
zstyle ':completion:*' list-dirs-first true                    # Directories before files
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored matches (matches ls)

# Grouping and Descriptions
zstyle ':completion:*' group-name ''                            # Enable grouping
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f' # Better header UI
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red} -- no matches found --%f'

# fzf-tab: Main configuration
zstyle ':fzf-tab:*' fzf-command fzf                            # Force use of fzf
zstyle ':fzf-tab:*' fzf-flags '--height=45% --layout=reverse --border=rounded'
zstyle ':fzf-tab:*' use-fzf-default-opts yes                   # Use your global fzf settings
zstyle ':fzf-tab:*' switch-group ',' '.'                       # Switch groups with , and .

# Awesome Previews
# - Preview directory contents when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
# - Preview file content for system commands (cat, bat, etc)
zstyle ':fzf-tab:complete:(cat|bat|vim|nvim|ls|eza):*' fzf-preview 'bat --color=always --style=plain --line-range=:100 $realpath 2>/dev/null || eza -1 --icons --color=always $realpath'

# Speed up completion by using a cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Smart path completion
zstyle ':completion:*' expand yes
zstyle ':completion:*' path-completion true

# =========================================================
# Fuzzy finder
# =========================================================

# macOS / Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  # Disabled default fzf completion as it conflicts with fzf-tab
  # source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# macOS / Homebrew (Intel)
if [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  # source /usr/local/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

# Plugins and plugin manager
# CRITICAL: Load plugins last. zsh-vi-mode re-initializes keymaps, so it must
# load after other plugins to ensure autosuggestions and highlighting can wrap
# its widgets correctly.
source "$ZDOTDIR/plugins.zsh"
