# Dotfiles

Cross-platform dotfiles managed with [chezmoi](https://www.chezmoi.io/). One command to install all tools, set up configs, and get a consistent dev environment on **macOS**, **Linux** (Ubuntu/Fedora/Arch), and **WSL**.

## Quick Start

### On a fresh machine (one-liner)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply venkatv4/dotfiles
```

### From a local clone

```bash
git clone https://github.com/venkatv4/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

On first run, chezmoi will prompt for your **git name** and **email**, then automatically install all tools and apply configs.

## Supported Platforms

| Platform | Package Manager | Architecture |
|----------|----------------|-------------|
| **macOS** | Homebrew | x86_64, arm64 (Apple Silicon) |
| **Ubuntu / Debian** | apt + GitHub releases | x86_64, arm64 |
| **Fedora / RHEL** | dnf + GitHub releases | x86_64, arm64 |
| **Arch Linux** | pacman | x86_64, arm64 |
| **WSL** | Same as Linux + Windows clipboard integration | x86_64, arm64 |

## What's Included

### Shell & Terminal

| Tool | Description |
|------|-------------|
| **zsh** | Default shell with zinit plugin manager |
| **tmux** | Terminal multiplexer (prefix: `C-a`, vim-style nav, TPM plugins) |
| **starship** | Cross-shell prompt with git, language, k8s, and docker context |

### Editor

| Tool | Description |
|------|-------------|
| **neovim** | Editor powered by [LazyVim](https://www.lazyvim.org/) (requires 0.11+) — telescope, treesitter, LSP (mason), cmp, neo-tree, and more out of the box |

### Git

| Tool | Description |
|------|-------------|
| **git** | Version control with OS-specific credential helpers |
| **git-delta** | Side-by-side diffs with syntax highlighting |
| **lazygit** | Terminal UI for git |
| **gh** | GitHub CLI |

### File Navigation & Search

| Tool | Description |
|------|-------------|
| **yazi** | Terminal file manager with image/video/PDF preview |
| **fzf** | Fuzzy finder |
| **ripgrep** | Fast grep replacement |
| **fd** | Fast find replacement |
| **eza** | Modern ls replacement |
| **zoxide** | Smarter cd (frecency-based) |

### Data & Web

| Tool | Description |
|------|-------------|
| **jq** | JSON processor |
| **yq** | YAML processor |
| **w3m** | Terminal web browser |
| **lynx** | Terminal web browser |
| **curl** | HTTP client |
| **wget** | HTTP downloader |

### Dev Environment

| Tool | Description |
|------|-------------|
| **direnv** | Auto-load `.envrc` per directory |
| **bat** | cat with syntax highlighting (Catppuccin theme) |

### Yazi Preview Dependencies

These are installed automatically to enable full preview support in yazi:

| Tool | Purpose |
|------|---------|
| **ffmpeg** | Video/audio thumbnails |
| **7zip** | Archive preview |
| **poppler** | PDF preview |
| **imagemagick** | Image format support (HEIC, JPEG XL, fonts) |
| **resvg** | SVG rendering (Arch/macOS only) |

### Zsh Plugins (via zinit)

- **zsh-autosuggestions** — fish-like autosuggestions
- **zsh-syntax-highlighting** — command syntax coloring
- **zsh-completions** — additional completions
- **fzf-tab** — fzf-powered tab completion

### Sway Window Manager (native Linux only)

A full [Sway](https://swaywm.org/) tiling WM setup with Catppuccin Mocha theming, installed only on native Linux (not WSL or macOS).

| Tool | Description |
|------|-------------|
| **sway** | i3-compatible Wayland compositor |
| **waybar** | Status bar |
| **wofi** | Application launcher |
| **swaync** | Notification center |
| **swaylock** | Lock screen |
| **wlogout** | Power/logout menu |
| **kanshi** | Auto display profile switching |
| **wlsunset** | Night light / blue light filter |
| **autotiling** | Auto alternate horizontal/vertical splits |
| **nwg-look** | GTK theme settings for Wayland |
| **grim** + **slurp** | Screenshots |
| **cliphist** | Clipboard history |
| **brightnessctl** | Screen brightness control |
| **playerctl** | Media playback control |

### Font

- **JetBrainsMono Nerd Font** — required for icons in neovim, lazygit, starship, yazi, and waybar

## OS-Specific Behavior

### macOS
- Installs Homebrew if not present
- Uses `osxkeychain` for git credentials
- `flush-dns` alias

### WSL
- `pbcopy` / `pbpaste` aliases mapped to Windows clipboard (`clip.exe` / `Get-Clipboard`)
- Git credential helper points to Windows Git Credential Manager

### Linux
- Tools not in distro repos are installed from GitHub releases (latest version, arch-aware)
- Neovim 0.11+ installed from GitHub releases (apt/dnf ship older versions)
- JetBrainsMono Nerd Font installed to `~/.local/share/fonts`
- **Sway WM** installed on native Linux with full Catppuccin Mocha theming
- GDM auto-login is disabled automatically so the session chooser (gear icon) appears at login — select "Sway" to use the tiling WM
- Wayland environment variables set conditionally when running under Sway

## Key Bindings

### Zsh
| Key | Action |
|-----|--------|
| `Ctrl-p` | History search backward |
| `Ctrl-n` | History search forward |

### Tmux (prefix: `C-a`)
| Key | Action |
|-----|--------|
| `\|` | Split horizontal |
| `-` | Split vertical |
| `h/j/k/l` | Navigate panes |
| `H/J/K/L` | Resize panes |
| `r` | Reload config |

### Neovim — [LazyVim](https://www.lazyvim.org/) (leader: `Space`)
| Key | Action |
|-----|--------|
| `<leader><space>` | Find files |
| `<leader>sg` | Live grep (telescope) |
| `<leader>,` | Switch buffers |
| `<leader>e` | File explorer (neo-tree) |
| `C-h/j/k/l` | Navigate windows |

See [LazyVim keymaps](https://www.lazyvim.org/keymaps) for the full list.

### Yazi
| Key | Action |
|-----|--------|
| `gh` | Go to home |
| `gc` | Go to ~/.config |
| `gd` | Go to ~/Downloads |
| `gp` | Go to ~/projects |
| `Ctrl-s` | Open shell in current dir |

### Sway (mod key: `Super`)
| Key | Action |
|-----|--------|
| `Super+Return` | Open terminal |
| `Super+d` | App launcher (wofi) |
| `Super+q` | Close window |
| `Super+h/j/k/l` | Focus left/down/up/right |
| `Super+Shift+h/j/k/l` | Move window |
| `Super+1-9` | Switch workspace |
| `Super+Shift+1-9` | Move window to workspace |
| `Super+f` | Fullscreen |
| `Super+Shift+space` | Toggle floating |
| `Super+Shift+e` | Power menu (wlogout) |

### Shell Aliases
| Alias | Command |
|-------|---------|
| `y` | yazi (cd on quit) |
| `lg` | lazygit |
| `g` | git |
| `gs` | git status -sb |
| `gl` | git log --oneline --graph |
| `cat` | bat (when available) |
| `ls` / `ll` | eza (when available) |

## Updating

After editing dotfiles in this repo:

```bash
chezmoi apply
```

To pull latest from remote and apply:

```bash
chezmoi update
```

## Adding a New Tool

1. Add the install command to `.chezmoiscripts/run_onchange_install-packages.sh.tmpl` for each package manager
2. Add any config files under `private_dot_config/<tool>/`
3. Run `chezmoi apply` — the install script re-runs automatically when it detects changes

## File Structure

```
dotfiles/
├── .chezmoi.toml.tmpl                              # chezmoi config (prompts for name/email, detects OS)
├── .chezmoiignore                                   # files to exclude from home dir
├── .chezmoiscripts/
│   └── run_onchange_install-packages.sh.tmpl        # auto-installs all tools
├── install.sh                                       # bootstrap script
├── dot_zshrc.tmpl                                   # ~/.zshrc (OS-aware)
├── dot_zshenv.tmpl                                   # ~/.zshenv (XDG, PATH, Wayland env vars)
├── dot_gitconfig.tmpl                               # ~/.gitconfig (OS-aware)
├── dot_tmux.conf                                    # ~/.tmux.conf
└── private_dot_config/
    ├── bat/config                                   # bat theme
    ├── lazygit/config.yml                           # lazygit settings
    ├── nvim/                                        # neovim (LazyVim)
    │   ├── init.lua                                 # bootstrap lazy.nvim
    │   └── lua/
    │       ├── config/                              # options, keymaps, autocmds
    │       └── plugins/                             # custom plugin specs
    ├── ripgrep/config                               # ripgrep defaults
    ├── starship.toml                                # prompt config
    ├── yazi/                                        # yazi file manager
    │   ├── yazi.toml
    │   ├── keymap.toml
    │   └── theme.toml
    ├── sway/config                                  # sway WM config
    ├── waybar/                                      # status bar
    │   ├── config.jsonc
    │   └── style.css
    ├── wofi/                                        # app launcher
    │   ├── config
    │   └── style.css
    ├── swaync/                                      # notifications
    │   ├── config.json
    │   └── style.css
    ├── swaylock/config                              # lock screen
    ├── wlogout/                                     # power menu
    │   ├── layout
    │   └── style.css
    └── kanshi/config                                # display profiles
```
