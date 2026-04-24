# ==================================================
# @file .zshrc
# @brief Zsh configuration file
# ==================================================

# --------------------------------------------------
# path
# --------------------------------------------------
typeset -U path PATH

path=(
	$HOME/.local/bin
	/opt/nvim/bin
	$HOME/.cargo/bin
	$HOME/go/bin
	$path
)

export PATH

# --------------------------------------------------
# aliases
# --------------------------------------------------

# safer operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ls
alias ls='ls -F --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=auto'

# nvim
alias view='nvim -R'

# disk
alias df='df -h'
alias du='du -h'
alias free='free -h'

# --------------------------------------------------
# history
# --------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# --------------------------------------------------
# shell behavior
# --------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB

# --------------------------------------------------
# less / pager
# --------------------------------------------------
export LESS='-R -F -X'
export PAGER='less'

if [[ -x /usr/bin/lesspipe ]]; then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

# --------------------------------------------------
# dircolors
# --------------------------------------------------
if command -v dircolors >/dev/null 2>&1; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# --------------------------------------------------
# completion
# --------------------------------------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''

if [[ -n "$LS_COLORS" ]]; then
	zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# --------------------------------------------------
# plugins
# --------------------------------------------------

# command-not-found
if [[ -f /etc/zsh_command_not_found ]]; then
	source /etc/zsh_command_not_found
fi

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
	source "$HOME/.fzf.zsh"
fi

# oh-my-posh
if command -v oh-my-posh >/dev/null 2>&1; then
	eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/themes/dark-dimmed.omp.json")"
fi

# zsh-autosuggestions
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting
if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
