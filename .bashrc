#       _               _
#      | |__   __ _ ___| |__  _ __ ___
#      | '_ \ / _` / __| '_ \| '__/ __|
#     _| |_) | (_| \__ \ | | | | | (__
#    (_)_.__/ \__,_|___/_| |_|_|  \___|

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# => Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
#-----------------------------------------------

# => History variables 
HISTCONTROL=ignoreboth #no duplicante and commands start with spaces
HISTSIZE=1000          #history size
HISTFILESIZE=2000      #~/.bash_history file size

# => shopt
shopt -s checkwinsize  #change rows and coulmns sizes after each command if needed
shopt -s histappend    #append do not overwrite 
shopt -s cmdhist       #multiline commans saved as 1 line in history
shopt -s autocd        #change dir witout cd command
shopt -s cdspell       #spellcheck for cd command
shopt -s dotglob       #*.* will include hidden files
#-----------------------------------------------

# => exports
export TERM="xterm-256color"     # getting proper colors

export LESS='-R --use-color -Dd+r$Du+b'

[ -x "$(command -v  vim)" ] && \
    export EDITOR="vim" || export EDITOR='nano'

[ -x "$(command -v  bat)" ] && \
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# => Aliasis
#package mnagers
[ -x "$(command -v nala)" ] && alias apt='sudo nala' && \
    alias aptup='sudo nala upgrade'

! [ -x "$(command -v nala)" ] && alias apt='sudo apt' || \
    alias aptup='sudo apt update && sudo apt upgrade'

[ -x "$(command -v aura)" ] && alias pacman='sudo aura' ||\
    alias pacman='sudo pacman'

#lsd as ls
[ -x "$(command -v lsd)" ] && alias ls='lsd -lAh' || \
    alias ls='ls -lAh --color=auto'

#bat as cat
[ -x "$(command -v bat)" ] && alias cat='bat'

#files and dir
alias cp='cp -ir'
alias mv='mv -i '
alias rm='rm -i'
alias rmdir='rm -r'
alias mkdir='mkdir -pv'

#grep
alias grep="grep --color=auto"
#-----------------------------------------------

# => Fancy Stuff
[ -x "$(command -v starship)" ] && eval "$(starship init bash)" || \
    PS1='\u@ \W ~~> '

[ -x "$(command -v figlet)" ] && [ -x "$(command -v  lolcat)"] && \
    figlet bash | lolcat
#-----------------------------------------------
