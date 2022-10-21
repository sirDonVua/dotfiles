#                  __ _          __ _     _
#  ___ ___  _ __  / _(_) __ _   / _(_)___| |__
# / __/ _ \| '_ \| |_| |/ _` | | |_| / __| '_ \
#| (_| (_) | | | |  _| | (_| |_|  _| \__ \ | | |
# \___\___/|_| |_|_| |_|\__, (_)_| |_|___/_| |_|
#                       |___/


#--------------------------------
#   exporting
#--------------------------------
# PATH
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
# fish
set fish_greeting            # fish greeting
set TERM "xterm-256color"    # prober colors
# text Editors
set EDITOR "vim"
set VISUAL "geany"
# MANPAGER
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
#--------------------------------

#--------------------------------
#   aliasis
#--------------------------------
# => pakage managers
# apt
alias apt     "sudo nala"
alias aptup   "sudo nala upgrade"
# dnf
alias dnf     "sudo dnf"
# pacman
alias pacman  "sudo aura"
alias wcpac   "aura -Q | wc -l"

# => ls,cat,grep
alias ls      "lsd -lAh"
alias cat     "bat"
alias grep    "grep --color=auto"

# => files and dir
alias cp      "cp -ir"
alias rm      "rm -i"
alias rmdir   "/usr/bin/env rm -r "
alias mv      "mv -i"
alias mkdir   "mkdir -pv"

# => starship prompt
starship init fish | source
#--------------------------------
