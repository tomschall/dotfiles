#!/usr/bin/env bash

set -euo pipefail

DRY_RUN="${DRY_RUN:-false}"
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "-------------------------------------"
echo "Tom's Dev Machine Setup"
echo "-------------------------------------"

# ------------------------------------------------

# Helper functions

# ------------------------------------------------

run() {
  if [ "$DRY_RUN" = true ]; then
    echo "[DRY RUN]" "$@"
  else
    "$@"
  fi
}

install_if_missing() {
  if ! brew list "$1" &>/dev/null; then
    echo "Installing $1"
    run brew install "$1"
  else
    echo "$1 already installed"
  fi
}

install_cask_if_missing() {
  if ! brew list --cask "$1" &>/dev/null; then
    echo "Installing $1"
    run brew install --cask "$1"
  else
    echo "$1 already installed"
  fi
}

safe_link() {
  src="$1"
  dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Skipping $dst (already exists)"
  else
    run ln -sf "$src" "$dst"
  fi
}

# ------------------------------------------------

# Install Homebrew

# ------------------------------------------------

if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."

  run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ "$DRY_RUN" = true ]; then
    echo '[DRY RUN] append brew shellenv to ~/.zprofile'
  else
    echo 'eval "$($(which brew) shellenv)"' >> ~/.zprofile
  fi
fi

if [ "$DRY_RUN" = false ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

run brew update

# ------------------------------------------------

# CLI tools

# ------------------------------------------------

install_if_missing git
install_if_missing gh
install_if_missing eza
install_if_missing bat
install_if_missing ripgrep
install_if_missing fd
install_if_missing jq
install_if_missing lazygit
install_if_missing zoxide
install_if_missing fzf
install_if_missing starship

# ------------------------------------------------

# ZSH plugins

# ------------------------------------------------

install_if_missing zsh-autosuggestions
install_if_missing zsh-syntax-highlighting

# ------------------------------------------------

# Dev tools

# ------------------------------------------------

install_if_missing node
install_if_missing pnpm
install_if_missing pyenv

# ------------------------------------------------

# Terminal tools

# ------------------------------------------------

install_if_missing btop
install_if_missing htop
install_if_missing dust

# ------------------------------------------------

# Apps

# ------------------------------------------------

install_cask_if_missing ghostty
install_cask_if_missing font-jetbrains-mono-nerd-font

# ------------------------------------------------

# Enable fzf

# ------------------------------------------------

if [ ! -f ~/.fzf.zsh ]; then
  run "$(brew --prefix)/opt/fzf/install" --all
fi

# ------------------------------------------------

# Save Ghostty config if present

# ------------------------------------------------

echo "Checking Ghostty config..."

run mkdir -p "$DOTFILES_DIR/.config/ghostty"

if [ -f ~/.config/ghostty/config ] && [ ! -f "$DOTFILES_DIR/.config/ghostty/config" ]; then
  echo "Saving current Ghostty config to dotfiles"
  run cp ~/.config/ghostty/config "$DOTFILES_DIR/.config/ghostty/config"
fi

# ------------------------------------------------

# Config directories

# ------------------------------------------------

run mkdir -p ~/.config
run mkdir -p ~/.config/ghostty

# ------------------------------------------------

# Link configs

# ------------------------------------------------

echo "Linking configs..."

safe_link "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
safe_link "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
safe_link "$DOTFILES_DIR/.config/ghostty/config" ~/.config/ghostty/config

# ------------------------------------------------

# Done

# ------------------------------------------------

echo ""
echo "-------------------------------------"
echo "Setup finished."
echo "Your environment is ready."
echo "Restart terminal."
echo "-------------------------------------"
