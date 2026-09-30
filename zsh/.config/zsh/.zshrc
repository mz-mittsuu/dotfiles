# ==================================================
# @file ~/.config/zsh/.zshrc
# @brief Interactive Zsh configuration
# ==================================================


# --------------------------------------------------
# Environment
# --------------------------------------------------

typeset -U fpath

export PAGER="less"
export LESS="-R -F -X"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"


# --------------------------------------------------
# Shell Behavior
# --------------------------------------------------

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB


# --------------------------------------------------
# History
# --------------------------------------------------

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY


# --------------------------------------------------
# Completion
# --------------------------------------------------

fpath=("$XDG_CACHE_HOME/zsh/completions" $fpath)

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select


# --------------------------------------------------
# Integrations
# --------------------------------------------------

# fzf
if (( $+commands[fzf] )); then
    if (( $+commands[fdfind] )); then
        export FZF_DEFAULT_COMMAND="fdfind --type file --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fdfind --type directory --hidden --follow --exclude .git"
    fi

    source <(fzf --zsh)
fi

# zoxide
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# Oh My Posh
if (( $+commands[oh-my-posh] )) && [[ -r "$XDG_CONFIG_HOME/oh-my-posh/theme.yml" ]]; then
    eval "$(oh-my-posh init zsh --strict --config "$XDG_CONFIG_HOME/oh-my-posh/theme.yml")"
fi


# --------------------------------------------------
# Key Bindings
# --------------------------------------------------

bindkey -e

# Ctrl + Left / Right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Home / End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Up / Down
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search


# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias df='df -h'
alias free='free -h'

if (( $+commands[batcat] )); then
    alias bat='batcat'
fi

if (( $+commands[eza] )); then
    alias ls='eza --icons=auto --group-directories-first'
    alias l='eza -l --icons=auto --group-directories-first'
    alias la='eza -a --icons=auto --group-directories-first'
    alias ll='eza -la --icons=auto --group-directories-first --git'
    alias tree='eza --tree --icons=auto --group-directories-first'
else
    alias ls='ls --color=auto'
    alias l='ls -lhF'
    alias la='ls -ah'
    alias ll='ls -lah'
fi

if (( $+commands[fdfind] )); then
    alias fd='fdfind'
fi


# --------------------------------------------------
# Hooks
# --------------------------------------------------

autoload -Uz add-zsh-hook

function chpwd_list() {
    if (( $+commands[eza] )); then
        eza --tree --level=1 -l --icons=auto --group-directories-first -- "$PWD"
    fi
}

add-zsh-hook chpwd chpwd_list


# --------------------------------------------------
# Zsh Plugins
# --------------------------------------------------

if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
