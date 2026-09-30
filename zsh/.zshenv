# ==================================================
# @file ~/.zshenv
# @brief Zsh startup environment
# ==================================================


# --------------------------------------------------
# XDG Base Directory
# --------------------------------------------------

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"


# --------------------------------------------------
# Zsh
# --------------------------------------------------

ZDOTDIR="$XDG_CONFIG_HOME/zsh"
skip_global_compinit=1


# --------------------------------------------------
# Path
# --------------------------------------------------

typeset -U path

path=("$HOME/.local/bin" $path)
