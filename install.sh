#!/bin/bash
# Bootstrap script — run this on a fresh machine:
#   curl -fsLS https://raw.githubusercontent.com/tsjeyaganesh/dotfiles/main/install.sh | bash
#
# Or clone and run:
#   git clone https://github.com/tsjeyaganesh/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh

set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/tsjeyaganesh/dotfiles.git}"

# ── Install apps if needed ─────────────────────────────────────────────
if command -v brew &>/dev/null; then
  # macOS (Homebrew)
  brew install \
    zsh vim neovim tmux \
    starship zoxide fzf ripgrep fd bat eza \
    git-delta lazygit gh \
    direnv jq yq curl wget \
    yazi ffmpeg sevenzip poppler imagemagick resvg w3m lynx || true

  brew install --cask nikitabobko/tap/aerospace || true

  brew install --cask alacritty font-jetbrains-mono-nerd-font || true

elif command -v apt-get &>/dev/null; then
  sudo apt-get update && sudo apt-get install -y \
    zsh vim tmux alacritty curl wget git jq unzip fontconfig build-essential \
    ripgrep bat fd-find fzf eza direnv \
    ffmpeg p7zip-full poppler-utils imagemagick w3m lynx \
    sway waybar wofi grim slurp wl-clipboard \
    swayidle swaylock swaybg kanshi autotiling wlogout \
    cliphist brightnessctl playerctl \
    sway-notification-center grimshot \
    xdg-desktop-portal-wlr || true

elif command -v dnf &>/dev/null; then
  sudo dnf install -y \
    zsh vim tmux alacritty curl wget git jq unzip fontconfig \
    fzf ripgrep fd-find bat direnv gcc make eza \
    ffmpeg p7zip poppler-utils ImageMagick w3m lynx \
    sway waybar wofi grim slurp wl-clipboard || true

elif command -v pacman &>/dev/null; then
  sudo pacman -Syu --noconfirm --needed \
    zsh vim neovim tmux alacritty \
    starship zoxide fzf ripgrep fd bat eza \
    git-delta lazygit github-cli \
    direnv jq yq curl wget base-devel \
    yazi ffmpeg p7zip poppler imagemagick resvg w3m lynx \
    sway waybar wofi grim slurp wl-clipboard || true

else
  echo "Warning: Could not detect package manager — install apps manually"
fi

# Install chezmoi if needed
if ! command -v chezmoi &>/dev/null; then
  echo "Installing chezmoi..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$PATH"
fi

# If running from the cloned repo, init from local path then apply
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ -f "${SCRIPT_DIR}/.chezmoi.toml.tmpl" ]]; then
  chezmoi init --source "${SCRIPT_DIR}"
  chezmoi apply --source "${SCRIPT_DIR}"
else
  chezmoi init --apply "$DOTFILES_REPO"
fi

# ── Sway: fix portal and waybar services ──────────────────────────────
if command -v sway &>/dev/null; then
  # Mask waybar.service — Sway launches waybar directly via exec_always
  if systemctl --user is-enabled waybar.service &>/dev/null; then
    echo "Disabling systemd waybar.service (Sway launches waybar directly)..."
    systemctl --user disable --now waybar.service 2>/dev/null || true
    systemctl --user mask waybar.service 2>/dev/null || true
  fi

  # Mask xdg-desktop-portal-gtk — it fails in Sway (no DISPLAY) and blocks
  # waybar startup with a 25s timeout
  echo "Masking xdg-desktop-portal-gtk.service (not needed under Sway)..."
  systemctl --user mask xdg-desktop-portal-gtk.service 2>/dev/null || true
fi

# ── Disable GDM auto-login ───────────────────────────────────────────
GDM_CONF="/etc/gdm3/custom.conf"
if [ -f "$GDM_CONF" ] && grep -q 'AutomaticLoginEnable=true' "$GDM_CONF"; then
  echo "Disabling GDM auto-login..."
  sudo sed -i 's/^AutomaticLoginEnable=true/AutomaticLoginEnable=false/' "$GDM_CONF"
fi

# ── Set default shell to zsh ──────────────────────────────────────────
if command -v zsh &>/dev/null && [ "$SHELL" != "$(command -v zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(command -v zsh)"
fi

echo ""
echo "Done! Restart your shell or run: exec zsh"
