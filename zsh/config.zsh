# Starship configuration
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export STARSHIP_CACHE=~/.starship/cache
eval "$(starship init zsh)"

# Format man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Mise (runtime manager)
eval "$(mise activate zsh)"

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# Atuin (shell history)
eval "$(atuin init zsh)"

# PATH additions
for p in ~/.local/bin ~/Applications/depot_tools; do
  if [[ -d "$p" ]] && [[ ":$PATH:" != *":$p:"* ]]; then
    export PATH="$p:$PATH"
  fi
done

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

######################
### Key Bindings  ####
######################
# Enable vim bindings
bindkey -v

# Zsh-specific settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST
setopt appendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt extended_history

##################
### Functions  ###
##################
# Backup function
backup() {
  if [[ -n "$1" ]]; then
    cp "$1" "$1.bak"
  else
    echo "Usage: backup <filename>"
  fi
}

# Enhanced copy function
copy() {
  local count=$#
  if [[ $count -eq 2 ]] && [[ -d "$1" ]]; then
    local from="${1%/}"  # Remove trailing slash
    local to="$2"
    command cp -r "$from" "$to"
  else
    command cp "$@"
  fi
}

# mkcd DIR
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
  local file="$1"
  if [[ -f "$file" ]]; then
    case "$file" in
      *.tar.bz2) tar xjf "$file" ;;
      *.tar.gz) tar xzf "$file" ;;
      *.bz2) bunzip2 "$file" ;;
      *.rar) unrar x "$file" ;;
      *.gz) gunzip "$file" ;;
      *.tar) tar xvf "$file" ;;
      *.tbz2) tar xjf "$file" ;;
      *.tgz) tar xzf "$file" ;;
      *.zip) unzip "$file" ;;
      *.Z) uncompress "$file" ;;
      *.7z) 7z x "$file" ;;
      *) echo "'$file' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$file' is not a valid file"
  fi
}

##################
### Aliases    ###
##################
# ls replacements (matching fish exactly)
alias ls='eza -al --color=always --group-directories-first --icons=always'
alias la='eza -a --color=always --group-directories-first --icons=always'
alias ll='eza -l --color=always --group-directories-first --icons=always'
alias lt='eza -aT --color=always --group-directories-first --icons=always'
alias l.='eza -a | grep -e "^\."'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# System helpers
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Arch helpers
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias update='sudo pacman -Syu'
alias mirror="sudo cachyos-rate-mirrors"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Shortcuts
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias jctl="journalctl -p 3 -xb"
alias nf='neofetch'
alias ff='fastfetch'
alias uf='uwufetch'
alias q='exit'
alias h='history'
alias c='clear'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcl='git clone'
alias gl='git log --oneline'
alias gd='git diff'
alias gpush='git push'
alias gpull='git pull'

# System control
alias wifi='nmtui'
alias install='yay -S'
alias search='yay -Ss'
alias lsearch='yay -Qs'
alias remove='yay -Rns'
alias shutdown='systemctl poweroff'
alias du='dust'

# Tool aliases
alias lg='lazygit'
alias lzd='lazydocker'
alias cd='z'

# Zsh-specific aliases
alias zshconfig='$EDITOR ~/.config/zsh/config.zsh'

######################
### Tool Reminder  ###
######################
TOOLBOX_FILE="$HOME/.config/zsh/toolbox.txt"

tools() {
  local file="$TOOLBOX_FILE"
  [[ ! -f "$file" ]] && { echo "toolbox.txt not found"; return 1; }

  if [[ "$1" == "-l" || "$1" == "--list" ]]; then
    # Print full cheat sheet
    while IFS= read -r line || [[ -n "$line" ]]; do
      if [[ "$line" =~ '^\[(.+)\]$' ]]; then
        printf '\033[1;36m%-14s\033[0m' "${match[1]}"
      elif [[ "$line" =~ '^desc: (.+)$' ]]; then
        printf ' %s\n' "${match[1]}"
      elif [[ "$line" =~ '^cmd: (.+)$' ]]; then
        printf '\033[2m%-14s → %s\033[0m\n' "" "${match[1]}"
      fi
    done < "$file"

  elif [[ $# -eq 0 ]]; then
    # Interactive fzf picker with tldr preview
    local pick
    pick=$(grep -oP '(?<=^\[).+(?=\]$)' "$file" | fzf --prompt="tool> " \
      --preview-window='right:80%:wrap-word' \
      --preview="
        awk -v tool={} '
          \$0 == \"[\" tool \"]\" { found=1; next }
          found && /^\[/ { exit }
          /^desc: / && found { printf \"\033[1;36m%s\033[0m\n\", substr(\$0,7) }
          /^cmd: / && found { printf \"\033[33m  → %s\033[0m\n\", substr(\$0,6) }
        ' \"$file\"
        printf \"\033[2m───────────────────────────────────\033[0m\n\"
        tldr --color always {} 2>/dev/null || echo 'No tldr page for {}'
      ")
    [[ -z "$pick" ]] && return
    # Show selected tool's details
    awk -v tool="$pick" '
      $0 == "[" tool "]" { found=1; next }
      found && /^\[/ { exit }
      found { print }
    ' "$file" | while IFS= read -r line; do
      if [[ "$line" =~ '^desc: (.+)$' ]]; then
        printf '\033[1;36m%s\033[0m — %s\n' "$pick" "${match[1]}"
      elif [[ "$line" =~ '^cmd: (.+)$' ]]; then
        printf '\033[2m  → %s\033[0m\n' "${match[1]}"
      fi
    done

  else
    # Keyword search
    local keyword="$*"
    local current_tool="" current_desc="" current_cmd="" matched=0
    while IFS= read -r line || [[ -n "$line" ]]; do
      if [[ "$line" =~ '^\[(.+)\]$' ]]; then
        # Print previous match if any
        if (( matched )); then
          printf '\033[1;36m%-14s\033[0m %s\n' "$current_tool" "$current_desc"
          [[ -n "$current_cmd" ]] && printf '\033[2m%-14s → %s\033[0m\n' "" "$current_cmd"
        fi
        current_tool="${match[1]}"
        current_desc="" current_cmd="" matched=0
      elif [[ "$line" =~ '^desc: (.+)$' ]]; then
        current_desc="${match[1]}"
      elif [[ "$line" =~ '^cmd: (.+)$' ]]; then
        current_cmd="${match[1]}"
      fi
      # Check match against tool name, desc, or cmd
      if [[ "${current_tool:l}" == *"${keyword:l}"* || \
            "${current_desc:l}" == *"${keyword:l}"* || \
            "${current_cmd:l}" == *"${keyword:l}"* ]]; then
        matched=1
      fi
    done < "$file"
    # Print last entry if matched
    if (( matched )); then
      printf '\033[1;36m%-14s\033[0m %s\n' "$current_tool" "$current_desc"
      [[ -n "$current_cmd" ]] && printf '\033[2m%-14s → %s\033[0m\n' "" "$current_cmd"
    fi
  fi
}

# Random tool tip on terminal open
() {
  local file="$TOOLBOX_FILE"
  [[ ! -f "$file" ]] && return

  local -a names descs cmds
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ '^\[(.+)\]$' ]]; then
      names+=("${match[1]}")
    elif [[ "$line" =~ '^desc: (.+)$' ]]; then
      descs+=("${match[1]}")
    elif [[ "$line" =~ '^cmd: (.+)$' ]]; then
      cmds+=("${match[1]}")
    fi
  done < "$file"

  local count=${#names[@]}
  (( count == 0 )) && return
  local idx=$(( RANDOM % count + 1 ))
  printf '\033[2mtip: \033[0;1m%s\033[0;2m — %s → try: \033[0;33m%s\033[0m\n' \
    "${names[$idx]}" "${descs[$idx]}" "${cmds[$idx]}"
}

# Zsh-specific plugins
# source $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh