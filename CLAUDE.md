# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Niri-dotfiles is a complete desktop environment configuration for the **Niri** scrollable-tiling Wayland compositor on Arch Linux. It provides preconfigured applications, dynamic wallpaper-based theming, and an automated installer. Version 2.1.

## Installation

The project is installed via a single command that runs `install.sh`:
```bash
curl -fsSL https://raw.githubusercontent.com/saatvik333/niri-dotfiles/main/install.sh | sh
```

There is no build system, test suite, or linter. The primary code artifact is `install.sh` (a ~1500-line Bash script) plus configuration files for various applications.

## Testing Changes

- **install.sh**: Test with `bash -n install.sh` for syntax checking. The script uses `set -Eeuo pipefail` and requires an Arch-based system to run.
- **Shell scripts**: Use `shellcheck scripts/*.sh` if shellcheck is available.
- **Niri config**: Validate with `niri validate` after changes to `niri/config.kdl`.

## Architecture

### Dynamic Theming System

The central architectural concept is **wallpaper-driven dynamic theming** using [Wallust](https://codeberg.org/explosion-mental/wallust):

1. User selects a wallpaper (via `scripts/bgselector.sh` → rofi → awww)
2. Wallust extracts colors from the wallpaper image
3. Wallust renders **template files** (`wallust/templates/`) into each app's config directory
4. `scripts/theme-sync.sh` orchestrates the full sync (runs wallust, reloads apps)

Template files use Wallust's `{{color0}}`–`{{color15}}` placeholders. Each template in `wallust/templates/` maps to a target path defined in `wallust/wallust.toml` under `[templates]`.

**Apps receiving dynamic colors:** Ghostty, Alacritty, Kitty, Waybar, GTK3/4, VSCode, Rofi, Mako, Zathura, Vicinae, Neovim (via neopywal).

### Config Directory Layout

Each application has its own top-level directory. When installed, these get symlinked into `~/.config/` from `~/.dotfiles-sevens/`:

| Directory | Application | Config Format |
|-----------|-------------|---------------|
| `ghostty/` | Terminal (default) | INI-style (`config`) |
| `niri/` | Window manager | KDL (`config.kdl`) |
| `waybar/` | Status bar | JSONC + CSS |
| `wallust/` | Theme engine | TOML + templates |
| `scripts/` | Utility scripts | Bash |
| `nvim/` | Neovim (LazyVim) | Lua |
| `rofi/` | App launcher | Rasi |
| `shells/fish/`, `shells/zsh/` | Shell configs | Fish/Zsh |
| `terminal_emulators/alacritty/`, `terminal_emulators/kitty/` | Terminals | TOML/Conf |
| `prompt/starship/` | Shell prompt | TOML |
| `notifications/mako/` | Notifications | Conf |
| `screen_lock/gtklock/` | Lock screen | INI + CSS |
| `file_managers/yazi/` | File manager | TOML |
| `pdf_viewer/zathura/` | PDF viewer | Custom |
| `system_info/fastfetch/` | System info | JSONC |
| `menu_launcher/vicinae/` | App menu | JSON |
| `systemd/` | User services | Systemd unit |

### Scripts

All utility scripts live in `scripts/` and share common logging via `scripts/lib/common.sh` (source it for `log_info`, `log_error`, `log_success`, `log_warn`, `log_debug`, `die`).

- **theme-sync.sh** — Orchestrates wallpaper → color extraction → app reload
- **bgselector.sh** — Wallpaper picker with thumbnail caching via rofi
- **media-control.sh** — Volume/brightness/playback wrapper (wpctl, brightnessctl)
- **low-battery-notify.sh** — Battery warning via systemd timer
- **git-cleanup.sh** — Git maintenance

### install.sh Structure

The installer is a single Bash script with 20 sequential steps:
- Pre-flight checks (not root, Arch-based, disk space, internet)
- System update, base tools, AUR helper setup (yay/paru)
- Rust toolchain via rustup
- Package installation (pacman + AUR)
- GTK/icon theme installation (Colloid, Rose-Pine, Osaka)
- Shell selection (Fish/Zsh), dotfiles clone, symlink creation
- Systemd user services, wallpaper submodule

Key constants are at the top: `REPO_URL`, `DOTDIR`, `CONFIG_DIR`, `PACMAN_PACKAGES`, `AUR_PACKAGES`, `CONFIG_FOLDERS`. The script uses comprehensive error handling with a cleanup trap and retry logic for network operations.

### Wallpapers

Wallpapers are a **git submodule** at `wallpapers/` pointing to a separate repository.

## Conventions

- Bash scripts use `set -Eeuo pipefail` with `IFS=$'\n\t'`
- Niri config uses KDL format (not TOML/JSON)
- Waybar uses split config: `config.jsonc` (layout) + `modules.json` (module definitions) + `style.css` + `colors.css` (dynamic from wallust)
- The MOD key is Super/Windows throughout niri keybindings
