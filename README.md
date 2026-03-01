# Niri WM Dotfiles

<div align="center">

**A productive and clean [Niri](https://github.com/YaLTeR/niri) configuration setup**
_Dank Material Shell • Material You theming • Minimal_

---

### Gallery

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b9221fe9-6e8f-4e26-b2a4-a67170512824" alt="Desktop View"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/c1184029-71d6-49a7-abb1-57661f738bad" alt="Workspace View"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/fba3cdae-5bbf-497c-b9f8-0cbd11c64d49" alt="Application Launcher"/></td>
  </tr>
</table>

---

</div>

## Contents

- [Features](#features)
- [Automatic Installation](#automatic-installation-recommended)
- [What Gets Installed](#what-gets-installed)
- [Keybinds](#keybinds)
  - [DMS Shell](#dms-shell)
  - [Applications](#applications)
  - [Window Management](#window-management)
  - [Workspace Management](#workspace-management)
  - [Monitor Management](#monitor-management)
  - [Layout Controls](#layout-controls)
  - [Window Modes](#window-modes)
  - [Utilities](#utilities)

## Features

- Material You design with [Dank Material Shell](https://github.com/nicobrinkkemper/dms-shell) (replaces waybar, mako, rofi, gtklock, wallust)
- Dynamic wallpaper-based theming via matugen (Material You color generation)
- Rounded corners, gaps, and shadows — all managed by DMS
- Out-of-Box preconfigured for all popular themes and applications

## Automatic Installation (Recommended)

For Arch Linux and Arch-based distributions (Manjaro, EndeavourOS, CachyOS, etc.):

```bash
curl -fsSL https://raw.githubusercontent.com/JPM1118/dotfiles/main/install.sh | sh
```

**Important Requirements:**

```
  Fresh or minimal Arch Linux installation recommended
  Active internet connection required
  Sudo privileges needed
  At least 5GB free disk space
```

### Pre-Install Snapshot (CachyOS / BTRFS)

If you're on CachyOS or any Arch-based distro with BTRFS + Snapper, take a snapshot before running the installer. The script runs `pacman -Syu` and symlinks into `~/.config/`, so having a restore point is recommended.

**Steps (in order):**

1. **Update and reboot first** — Snapper can't roll back kernel updates, so get on the latest kernel before snapshotting:
   ```bash
   sudo pacman -Syu && reboot
   ```

2. **Create a Snapper snapshot:**
   ```bash
   sudo snapper create --type single --description "Before niri-dotfiles"
   ```

3. **Back up your home config** — Snapper's default config only covers `/` (root), not `/home`:
   ```bash
   cp -rL ~/.config ~/config-backup-$(date +%Y%m%d)
   cp ~/.zshrc ~/.zshrc.manual-backup 2>/dev/null
   ```

4. **Run the install command** (see above).

**To restore:** Boot into the snapshot from the Limine bootloader's Snapshots menu, then restore your home configs from the manual backup. See the [CachyOS BTRFS Snapshots wiki](https://wiki.cachyos.org/configuration/snapper/) for full documentation.

What the Script Does

The automated installer will:

```
   Verify system compatibility (Arch-based only)
   Update your system packages
   Install base development tools (git, base-devel, curl)
   Set up AUR helper (yay/paru)
   Configure Rust toolchain
   Install all required packages (niri, ghostty, fish, etc.)
   Install AUR packages (dms-shell-bin, matugen, cliphist)
   Clone and configure dotfiles
   Run DMS setup and enable systemd service
   Set up shell configuration (Fish/Zsh)
   Install wallpapers
   Backup existing configurations
```

Installation Time: Approximately 15-30 minutes depending on your internet speed.

# What Gets Installed

Core Components

    Window Manager: Niri (Scrollable-tiling Wayland compositor)
    Desktop Shell: Dank Material Shell (bar, notifications, launcher, lock screen, theming)
    Terminal: Ghostty (default), Alacritty, Kitty
    Shell: Fish (with optional Zsh)
    Theming: matugen (Material You color generation)

Additional Tools

    Editor: Neovim (preconfigured)
    File Manager: Yazi (TUI), Thunar (GUI)
    PDF Viewer: Zathura
    System Info: Fastfetch
    Prompt: Starship
    Clipboard: cliphist + wl-clipboard
    Utilities: dust, eza, cava

Development Tools

    Rust toolchain (rustup, cargo)
    Base development packages
    Git and build essentials

## DMS Replaces

DMS is an all-in-one desktop shell that replaces the following discrete components from the previous setup:

| Old Component | Replaced By |
|---------------|-------------|
| Waybar (status bar) | DMS bar |
| Mako (notifications) | DMS notification center |
| Rofi/Vicinae (launcher) | DMS spotlight (MOD+Space) |
| GTKLock (lock screen) | DMS lock screen (MOD+Alt+L) |
| awww-daemon (wallpaper) | DMS wallpaper manager (MOD+Y) |
| Wallust (theming) | DMS + matugen (Material You) |

## Keybinds

> **Note:** `MOD` key is the Super/Windows key by default.

### DMS Shell

| Keybind | Action |
|---------|--------|
| `MOD + Space` | Application launcher (DMS spotlight) |
| `MOD + V` | Clipboard manager |
| `MOD + M` | Task manager |
| `MOD + N` | Notification center |
| `MOD + Comma` | DMS settings |
| `MOD + Y` | Browse wallpapers |
| `MOD + Alt + L` | Lock screen |
| `MOD + Shift + N` | Notepad |
| `Super + X` | Power menu |

### Applications

| Keybind | Action |
|---------|--------|
| `MOD + Return` | Open terminal (Ghostty) |
| `MOD + Alt + Return` | Open terminal (Alacritty) |
| `MOD + B` | Open browser (Firefox Developer Edition) |
| `MOD + Alt + B` | Open browser (Google Chrome) |
| `MOD + E` | Open file manager (Thunar) |
| `MOD + Alt + E` | Open file manager (Yazi) |

### Media Controls

| Keybind | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Increase volume (DMS) |
| `XF86AudioLowerVolume` | Decrease volume (DMS) |
| `XF86AudioMute` | Mute/unmute audio (DMS) |
| `XF86AudioMicMute` | Mute/unmute microphone (DMS) |
| `XF86MonBrightnessUp` | Increase brightness (DMS) |
| `XF86MonBrightnessDown` | Decrease brightness (DMS) |
| `XF86AudioPlay/Pause` | Play/pause media (DMS) |
| `XF86AudioNext/Prev` | Next/previous track (DMS) |

> **Note:** All media keys work even when the screen is locked. DMS handles these via IPC.

### Window Management

#### Focus Windows

| Keybind | Action |
|---------|--------|
| `MOD + H` or `MOD + Left` | Focus column left |
| `MOD + J` | Focus workspace down |
| `MOD + K` | Focus workspace up |
| `MOD + L` or `MOD + Right` | Focus column right |
| `MOD + Home` | Focus first column |
| `MOD + End` | Focus last column |
| `MOD + Q` | Close focused window |

#### Move Windows

| Keybind | Action |
|---------|--------|
| `MOD + Shift + H` or `MOD + Shift + Left` | Move column left |
| `MOD + Shift + J` | Move column to workspace down |
| `MOD + Shift + K` | Move column to workspace up |
| `MOD + Shift + L` or `MOD + Shift + Right` | Move column right |
| `MOD + Shift + Home` | Move column to first position |
| `MOD + Shift + End` | Move column to last position |

#### Mouse Navigation

| Keybind | Action |
|---------|--------|
| `MOD + Scroll Down` | Focus workspace down |
| `MOD + Scroll Up` | Focus workspace up |
| `MOD + Scroll Right` | Focus column right |
| `MOD + Scroll Left` | Focus column left |

### Workspace Management

#### Navigate Workspaces

| Keybind | Action |
|---------|--------|
| `MOD + 1-9` | Switch to workspace 1-9 |
| `MOD + Tab` | Switch to previous workspace |
| `MOD + Escape` | Toggle overview mode |
| `Alt + Tab` | Window switcher |

#### Move Windows to Workspaces

| Keybind | Action |
|---------|--------|
| `MOD + Shift + 1-9` | Move window to workspace 1-9 |

### Monitor Management

#### Focus Monitors

| Keybind | Action |
|---------|--------|
| `MOD + Ctrl + H` or `MOD + Ctrl + Left` | Focus monitor left |
| `MOD + Ctrl + L` or `MOD + Ctrl + Right` | Focus monitor right |
| `MOD + Ctrl + K` or `MOD + Ctrl + Up` | Focus monitor up |
| `MOD + Ctrl + J` or `MOD + Ctrl + Down` | Focus monitor down |

#### Move Windows to Monitors

| Keybind | Action |
|---------|--------|
| `MOD + Shift + Ctrl + H` or `MOD + Shift + Ctrl + Left` | Move to monitor left |
| `MOD + Shift + Ctrl + L` or `MOD + Shift + Ctrl + Right` | Move to monitor right |
| `MOD + Shift + Ctrl + K` or `MOD + Shift + Ctrl + Up` | Move to monitor up |
| `MOD + Shift + Ctrl + J` or `MOD + Shift + Ctrl + Down` | Move to monitor down |

### Layout Controls

| Keybind | Action |
|---------|--------|
| `MOD + C` | Center focused column |
| `MOD + Ctrl + C` | Center all visible columns |
| `MOD + R` | Cycle preset column widths |
| `MOD + Shift + R` | Cycle preset window heights |
| `MOD + [` | Decrease column width by 10% |
| `MOD + ]` | Increase column width by 10% |
| `MOD + Shift + [` | Decrease window height by 10% |
| `MOD + Shift + ]` | Increase window height by 10% |

### Window Modes

| Keybind | Action |
|---------|--------|
| `MOD + Shift + T` | Toggle window floating |
| `MOD + F` | Maximize column |
| `MOD + Shift + F` | Toggle fullscreen |
| `MOD + Shift + M` | Maximize column (alternate) |
| `MOD + W` | Toggle column tabbed display |

### Utilities

| Keybind | Action |
|---------|--------|
| `MOD + S` | Take screenshot (selection) |
| `MOD + Shift + S` | Screenshot entire screen |
| `MOD + Ctrl + S` | Screenshot current window |
| `MOD + P` | Color picker (hyprpicker) |

---
