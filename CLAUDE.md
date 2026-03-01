# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Niri-dotfiles is a complete desktop environment configuration for the **Niri** scrollable-tiling Wayland compositor on Arch Linux, using **Dank Material Shell (DMS)** as the integrated desktop shell. DMS replaces the previous discrete components (waybar, mako, rofi, gtklock, wallust, awww, vicinae) with a single all-in-one system. Version 3.0.

## Installation

The project is installed via a single command that runs `install.sh`:
```bash
curl -fsSL https://raw.githubusercontent.com/JPM1118/dotfiles/main/install.sh | sh
```

There is no build system, test suite, or linter. The primary code artifact is `install.sh` (a ~1500-line Bash script) plus configuration files for various applications.

## Testing Changes

- **install.sh**: Test with `bash -n install.sh` for syntax checking. The script uses `set -Eeuo pipefail` and requires an Arch-based system to run.
- **Shell scripts**: Use `shellcheck scripts/*.sh` if shellcheck is available.
- **Niri config**: Validate with `niri validate` after changes to `niri/config.kdl`.
- **DMS health**: Run `dms doctor` to check DMS status.

## Architecture

### Dank Material Shell (DMS)

DMS is the central desktop shell providing:
- **Status bar** (replaces waybar)
- **Notifications** (replaces mako) — toggle with MOD+N
- **Application launcher** (replaces rofi/vicinae) — spotlight at MOD+Space
- **Lock screen** (replaces gtklock) — MOD+Alt+L
- **Wallpaper management** (replaces awww) — MOD+Y
- **Dynamic theming** (replaces wallust) — via matugen (Material You color generation)
- **Clipboard manager** — MOD+V
- **Task manager** — MOD+M
- **Settings panel** — MOD+Comma

DMS is managed as a systemd user service (`systemctl --user status dms`). It generates niri configuration fragments in `~/.config/niri/dms/` which are included by the main config.

### DMS-Generated Files (not tracked in git)

DMS auto-generates these files at runtime:
- `niri/dms/*.kdl` — layout, colors, binds, alttab, cursor, windowrules, outputs
- `alacritty/colors.toml` — terminal colors
- `kitty/colors.conf` — terminal colors
- `ghostty/themes/dankcolors` — terminal theme
- `DankMaterialShell/` — DMS internal state

These are listed in `.gitignore` and should not be committed.

### Niri Config Structure

The niri config (`niri/config.kdl`) uses KDL format and is structured as:
1. **DMS includes** at the top (colors, layout, binds, alttab, cursor, windowrules, outputs)
2. **User overrides** below (input prefs, custom keybinds, window rules, animations, environment)

User binds that differ from DMS defaults are placed after the includes so they take precedence. Key differences from DMS defaults:
- MOD+J/K → workspace navigation (not window focus within column)
- MOD+Escape → overview (not MOD+D)
- MOD+Tab → previous workspace (not overview)
- MOD+Return → terminal (DMS uses MOD+T)
- MOD+Shift+M → maximize column (DMS uses MOD+M for task manager)

### Config Directory Layout

Each application has its own top-level directory. When installed, these get symlinked into `~/.config/` from `~/.dotfiles-sevens/`:

| Directory | Application | Config Format |
|-----------|-------------|---------------|
| `niri/` | Window manager | KDL (`config.kdl`) |
| `ghostty/` | Terminal (default) | INI-style (`config`) |
| `alacritty/` | Terminal | TOML |
| `kitty/` | Terminal | Conf |
| `nvim/` | Neovim (LazyVim) | Lua |
| `fish/` | Fish shell | Fish |
| `zsh/` | Zsh shell | Zsh |
| `starship/` | Shell prompt | TOML |
| `fastfetch/` | System info | JSONC |
| `yazi/` | File manager | TOML |
| `zathura/` | PDF viewer | Custom |
| `scripts/` | Utility scripts | Bash |
| `systemd/` | User services | Systemd unit |

### Scripts

Utility scripts in `scripts/` share common logging via `scripts/lib/common.sh` (source it for `log_info`, `log_error`, `log_success`, `log_warn`, `log_debug`, `die`).

- **low-battery-notify.sh** — Battery warning via systemd timer
- **git-cleanup.sh** — Git maintenance

### install.sh Structure

The installer is a single Bash script with 17 sequential steps:
- Pre-flight checks (not root, Arch-based, disk space, internet)
- System update, base tools, AUR helper setup (yay/paru)
- Rust toolchain via rustup
- Package installation (pacman + AUR including dms-shell-bin, matugen, cliphist)
- Shell selection (Fish/Zsh), dotfiles clone, symlink creation
- DMS setup and systemd service enablement
- Wallpaper submodule installation

Key constants are at the top: `REPO_URL`, `DOTDIR`, `CONFIG_DIR`, `PACMAN_PACKAGES`, `AUR_PACKAGES`, `CONFIG_FOLDERS`.

### Wallpapers

Wallpapers are a **git submodule** at `wallpapers/` pointing to a separate repository.

## Conventions

- Bash scripts use `set -Eeuo pipefail` with `IFS=$'\n\t'`
- Niri config uses KDL format (not TOML/JSON)
- The MOD key is Super/Windows throughout niri keybindings
- DMS-generated files are excluded from version control via `.gitignore`
- Terminal color files are generated at runtime by DMS/matugen, not stored in the repo
