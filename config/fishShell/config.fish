#Export#
set -U fish_greeting
set -x EDITOR "vim"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
#End#

##alias##
alias apt='sudo nala'
alias pkgup='sudo nala upgrade'
alias fishrc="vim ~/.config/fish/config.fish"
alias deb='deb-get'
alias ls='lsd'
alias lt='lsd --tree'
alias cat='bat'

##End##

###commands run When luanch###
figlet fish -c | lolcat
#colorscript -r
#starship init fish | source
###END###
