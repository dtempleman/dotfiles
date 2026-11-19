# ~/.bash_profile: read by bash login shells (ssh logins, tty consoles).
# Bash reads this instead of ~/.profile, so it loads both itself.

# machine-local login settings (on Ubuntu this also loads ~/.bashrc)
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

# in case there is no ~/.profile, or it doesn't load ~/.bashrc
if [ -z "${__BASHRC_LOADED:-}" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
