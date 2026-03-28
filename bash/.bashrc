# ==================================================
# @file .bashrc
# @brief Bash configuration file
# ==================================================

# --------------------------------------------------
# path
# --------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/nvim/bin:$PATH"

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
alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'

# disk
alias df='df -h'
alias du='du -h'
alias free='free -h'

# --------------------------------------------------
# history
# --------------------------------------------------
HISTFILE="$HOME/.bash_history"
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend
shopt -s cmdhist

HISTCONTROL=ignoredups:ignorespace

# --------------------------------------------------
# shell behavior
# --------------------------------------------------
shopt -s autocd
shopt -s globstar
shopt -s checkwinsize

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
# bash-completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# --------------------------------------------------
# plugins
# --------------------------------------------------

# command-not-found
if [[ -f /etc/bash_command_not_found ]]; then
    source /etc/bash_command_not_found
fi

# fzf
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
fi

if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
fi

# --------------------------------------------------
# prompt
# --------------------------------------------------
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init bash --config "$HOME/.config/oh-my-posh/themes/dark-dimmed.omp.json")"
fi
. "$HOME/.cargo/env"
