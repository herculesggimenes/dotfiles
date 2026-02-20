#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew (if needed)"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing Homebrew packages"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> Symlinking dotfiles"
link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "  backup: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "  linked: $dst -> $src"
}

link "$DOTFILES/zshrc"    "$HOME/.zshrc"
link "$DOTFILES/zprofile" "$HOME/.zprofile"
link "$DOTFILES/bashrc" "$HOME/.bashrc"
link "$DOTFILES/bash_profile" "$HOME/.bash_profile"
link "$DOTFILES/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/tool-versions" "$HOME/.tool-versions"
link "$DOTFILES/Brewfile" "$HOME/.Brewfile"

mkdir -p "$HOME/.config"
link "$DOTFILES/config/nvim"    "$HOME/.config/nvim"
link "$DOTFILES/config/ghostty" "$HOME/.config/ghostty"
link "$DOTFILES/config/lazygit" "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/git" "$HOME/.config/atuin"
link "$DOTFILES/config/git/ignore" "$HOME/.config/git/ignore"
link "$DOTFILES/config/atuin/config.toml" "$HOME/.config/atuin/config.toml"
mkdir -p "$HOME/.codex" "$HOME/.claude"
link "$DOTFILES/config/codex/config.toml" "$HOME/.codex/config.toml"
link "$DOTFILES/config/claude/settings.json" "$HOME/.claude/settings.json"

echo "==> Installing tmux plugin manager"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "==> Installing Node LTS via fnm"
if command -v fnm &>/dev/null; then
  fnm install --lts
fi

echo "==> Installing Claude Code"
if command -v pnpm &>/dev/null; then
  pnpm install -g @anthropic-ai/claude-code
fi

echo "==> Done! Restart your terminal or run: source ~/.zshrc"
