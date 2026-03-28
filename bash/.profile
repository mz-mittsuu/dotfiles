# ==================================================
# @file .profile
# @brief Bash profile configuration file
# ==================================================

if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
. "$HOME/.cargo/env"
