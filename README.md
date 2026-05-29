# sonvt_dotfiles

Personal dotfiles managed from this repository.

## Layout

- `.config/zsh/` - zsh configuration files

## Required Packages

The zsh config expects these command-line tools to be available:

| Tool | Used For |
|------|----------|
| `zsh` | Shell |
| `git` | Plugin installation and normal development workflow |
| `zoxide` | Smart `cd` replacement |
| `eza` | `ls`, `ll`, `la`, and `tree` aliases |
| `bat` | `cat` alias and fzf previews |
| `fd` | fzf file search |
| `fzf` | Fuzzy file/history search |
| `ripgrep` | `grep` alias |
| `neovim` | `vim` alias |
| `starship` | Prompt |
| `lf` | Optional `lf()` directory-jump helper |
| `mpv` | Optional `stream` webcam alias |

### macOS

```sh
brew install zsh git zoxide eza bat fd fzf ripgrep neovim starship lf mpv
```

### Arch Linux

```sh
sudo pacman -S zsh git zoxide eza bat fd fzf ripgrep neovim starship lf mpv
```

If you use an AUR helper and a package is unavailable in your configured repos:

```sh
paru -S zsh git zoxide eza bat fd fzf ripgrep neovim starship lf mpv
```

### Ubuntu / Debian

```sh
sudo apt update
sudo apt install zsh git zoxide eza bat fd-find fzf ripgrep neovim lf mpv
curl -sS https://starship.rs/install.sh | sh
```

Ubuntu and Debian may install `bat` and `fd` under different binary names:

```sh
mkdir -p ~/.local/bin
ln -sf "$(command -v batcat)" ~/.local/bin/bat
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
```

### Fedora

```sh
sudo dnf install zsh git zoxide eza bat fd-find fzf ripgrep neovim starship lf mpv
```

## Optional Tools Referenced By `.zshrc`

These are only needed if you use the matching parts of the personal shell setup:

| Tool | Purpose |
|------|---------|
| `pyenv` | Python version management |
| `fnm` | Node.js version management |
| `pnpm` | Node package manager and global binaries |
| `bun` | Bun runtime and package manager |
| `gvm` | Go version management |
| `sdkman` | JVM ecosystem version management |
| `conda` | Python/data science environments |
| `oh-my-posh` | Legacy prompt init still present in `.zshrc` |

## Install Dotfiles

Use symlinks or GNU Stow to link files into `$HOME`.

Example with GNU Stow:

```sh
cd ~/sonvt_dotfiles
stow .
```
