# Niri WM Dotfiles

Productive and clean niri configuration setup.

## Features

- Clean borderless, gapless minimal look
- Dynamic theme switching system-wide
- Out-of-Box preconfigured for all popular themes and applications
- Rust-powered tooling and packages (rust go brrr...)

## Automatic Installation (Recommended)

For Arch Linux and Arch-based distributions (Manjaro, EndeavourOS, etc.):
```bash
curl -fsSL https://raw.githubusercontent.com/saatvik333/niri-dotfiles/main/install.sh | sh
```

 **Important Requirements:**
```
  Fresh or minimal Arch Linux installation recommended
  Active internet connection required
  Sudo privileges needed
  At least 5GB free disk space
```
What the Script Does

The automated installer will:
```
   Verify system compatibility (Arch-based only) 
   Update your system packages 
   Install base development tools (git, base-devel, curl) 
   Set up AUR helper (yay) 
   Configure Rust toolchain 
   Install all required packages (niri, waybar, fish, etc.) 
   Install AUR packages (vicinae, wallust, etc.) 
   Install GTK themes (Colloid, Rose Pine, Osaka) 
   Install icon themes (Colloid icons) 
   Clone and configure dotfiles 
   Set up shell configuration (Fish/Zsh) 
   Create systemd services 
   Install wallpapers  
   Backup existing configurations 
```
Installation Time: Approximately 15-30 minutes depending on your internet speed.

 What Gets Installed
 
Core Components

    Window Manager: Niri (Scrollable-tiling Wayland compositor)
    Status Bar: Waybar (Highly customizable)
    Terminal: Alacritty, Kitty
    Shell: Fish (with optional Zsh)
    Notification Daemon: Mako
    Application Launcher: Rofi
    Screen Locker: GTKLock
    Wallpaper Manager: SWWW

Additional Tools

    Editor: Neovim (preconfigured)
    File Manager: Yazi (TUI), Thunar (GUI)
    PDF Viewer: Zathura
    System Info: Fastfetch
    Theme Manager: Wallust
    Prompt: Starship
    Authentication: Polkit-gnome
    Utilities: dust, eza, niri-switch

Development Tools

    Rust toolchain (rustup, cargo)
    Base development packages
    Git and build essentials


## Themes

[Wallust](https://codeberg.org/explosion-mental/wallust) is used for the theming using it's color palettes and it's palette generation using wallpaper.

|Theme|GTK Theme|Icon Theme|
|--|--|--|
| Catppuccin | [Colloid (Light/Dark) Catppuccin](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid Catppuccin (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Everforest | [Colloid (Light/Dark) Everforest](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid Everforest (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Gruvbox | [Colloid (Light/Dark) Gruvbox](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid Gruvbox (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Nord | [Colloid (Light/Dark) Nord](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid Nord (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Rosé Pine | [Rose Pine GTK Theme (Light/Dark)](https://github.com/Fausto-Korpsvart/Rose-Pine-GTK-Theme) | [Colloid Catppuccin (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Dracula | [Colloid (Light/Dark) Dracula](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid Dracula (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Material | [Colloid Grey (Light/Dark)](https://github.com/vinceliuice/Colloid-gtk-theme) | [Colloid (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |
| Solarized | [Osaka GTK Theme (Light/Dark)](https://github.com/Fausto-Korpsvart/Osaka-GTK-Theme) | [Colloid Everforest (Light/Dark)](https://github.com/vinceliuice/Colloid-icon-theme) |

Thanks to [vinceliuice](https://github.com/vinceliuice) and [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart) for providing awesome GTK themes.

## Preconfigured tools

- Neovim
- Yazi
- Rofi
- Waybar
- Fish
- Fastfetch
- Mako
- Alacritty
- Kitty
- Starship
