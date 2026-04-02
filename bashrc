# ~/.bashrc - Dark Moss theme

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
MOSS='\[\e[38;2;97;210;157m\]'
MOSS2='\[\e[38;2;21;223;107m\]'
COBALT='\[\e[38;2;40;154;255m\]'
AQUA='\[\e[38;2;10;247;255m\]'
DIM='\[\e[38;2;187;187;187m\]'
RESET='\[\e[0m\]'

# Prompt
PS1="${MOSS}\u${DIM}@${COBALT}\h${DIM}:${AQUA}\w${MOSS} \$${RESET} "

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Aliases - Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# Aliases - Files
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'

# Aliases - System
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='pacman -Ss'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='ss -tulanp'
alias myip='curl ifconfig.me'
alias ping='ping -c 5'

# Aliases - Config shortcuts
alias i3config='nano ~/.config/i3/config'
alias polyconfig='nano ~/.config/polybar/config.ini'
alias bashrc='nano ~/.bashrc'
alias tmuxconf='nano ~/.tmux.conf'
alias reload='source ~/.bashrc'

# Aliases - Tmux
alias t='tmux'
alias ta='tmux attach'
alias tls='tmux ls'
alias tn='tmux new -s'

# Aliases - USB
alias mountusb='sudo mount /dev/sdb1 /mnt/usb'
alias umountusb='sudo umount /mnt/usb'

# Functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.7z)        7z x "$1"      ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

note() {
    echo "$(date): $*" >> ~/notes.txt
}

notes() {
    cat ~/notes.txt
}

# Man page colors
export LESS_TERMCAP_mb=$'\e[38;2;97;210;157m'
export LESS_TERMCAP_md=$'\e[38;2;40;154;255m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[38;2;21;223;107m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[38;2;10;247;255m'

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Auto-start tmux: attach to 'main' or create it
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz 2>/dev/null
    tmux new-session -d -s main
    tmux split-window -h -t main
    tmux split-window -v -t main:1.2
    tmux send-keys -t main:1.3 'clear && cat ~/.tmux-help.txt' C-m
    tmux select-pane -t main:1.1
    exec tmux attach -t main
fi

# fastfetch on open
fastfetch
