# Created by newuser for 5.9.2

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Created by `pipx` on 2026-09-23 20:04:45
export PATH="$PATH:/home/nasser/.local/bin"
export PATH="$PATH:/home/nasser/.cargo/bin"

cat ~/.cache/iris/sequences

#alias notify-send="notify-send.sh"
alias ls="eza -l --icons --group-directories-first"
alias xbinstall="vuru install"
alias xbremove="vuru remove"
alias xbsearch="vuru search"
alias xbupdate="vuru update"
alias cat="bat"
alias n="nvim"
alias leet="nvim leetcode.nvim"

function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}

# History file location and size limits
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# History performance and sharing settings
setopt EXTENDED_HISTORY          # Write timestamps to history
setopt SHARE_HISTORY             # Share history across all active terminal sessions
setopt INC_APPEND_HISTORY        # Write to history file immediately, not on exit
setopt HIST_IGNORE_DUPS          # Don't record duplicate consecutive commands
setopt HIST_IGNORE_ALL_DUPS      # Remove old duplicate entries when saving new ones
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

export HYPRSHOT_DIR="${HOME}/Pictures/Screenshots"
export EDITOR=nvim
# opencode
export PATH=/home/nasser/.opencode/bin:$PATH
export XDEB_PKGROOT="${HOME}/.config/xdeb"

# Added by vibez installer
export PATH="${HOME}/.local/bin:${PATH}"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/nasser/.lmstudio/bin"
# End of LM Studio CLI section

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # enable non case sensitive autocomplete and make it smarter overall.

source ~/.antidote/antidote.zsh
antidote load

autoload -Uz compinit
compinit -C

setopt prompt_subst
unsetopt PROMPT_SP

zsh-defer -c 'eval "$(starship init zsh)"'
eval "$(zoxide init zsh)"
source <(fzf --zsh)
autoload -U compinit; compinit
