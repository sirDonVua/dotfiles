#       _               _
#      | |__   __ _ ___| |__  _ __ ___
#      | '_ \ / _` / __| '_ \| '__/ __|
#     _| |_) | (_| \__ \ | | | | | (__
#    (_)_.__/ \__,_|___/_| |_|_|  \___|


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# => checks for neded packages

# => History variables 
HISTCONTROL=ignoreboth #no duplicante and commands start with spaces
HISTSIZE=1000          #history size
HISTFILESIZE=2000      #~/.bash_history file size



# => shopt
shopt -s checkwinsize  #change rows and coulmns sizes after each command if needed
shopt -s histappend    #append do not overwrite 
shopt -s cmdhist       #multiline commans saved as 1 line in history
#shopt -s globstar
shopt -s autocd        #change dir witout cd command
shopt -s cdspell       #spellcheck for cd command
shopt -s dotglob       #*.* will include hidden files

# => tab completion
. /usr/share/bash-completion/bash_completion || \
    . /etc/bash_completion
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"


# => exports
export TERM="xterm-256color"     # getting proper colors

[[ -f /usr/bin/vim ]]  && \
    export EDITOR="vim"

[[ -f /usr/bin/bat ]]  && \
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"


# => Aliasis
#package mnagers
[[ -f /usr/bin/nala ]] && alias apt='sudo nala' || \
    alias apt='sudo apt'

[[ -f /usr/bin/nala ]] && alias aptup='sudo nala upgrade' || \
    alias aptup='sudo apt update && sudo apt upgrade'

alias deb='deb-get'
alias nix='nix-env'

#lsd as ls
[[ -f /usr/bin/lsd ]]  && alias ls='lsd' && alias lt='lsd --tree'|| \
    alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'

#bat as cat & mkdir parent and childs
[[ -f /usr/bin/bat ]] && alias cat='bat'
alias mkdir='mkdir -pv'

#files and dir
alias cp='cp -ir'
alias mv='mv -i '
alias rm='rm -ir'

#config files
alias bashrc='$EDITOR $HOME/.bashrc && . $HOME/.bashrc'
alias fishrc='$EDITOR $HOME/.config/fish/config.fish'


# => NIX package manager
[[ -d $HOME/.nix-profile  ]] && \
    . ~/.nix-profile/etc/profile.d/nix.sh
	export XDG_DATA_DIRS=~/.local/share/:~/.nix-profile/share:/usr/share && \
	[[ -d $HOME/.nix-profile/share/applications/ ]] && \
        cp -f ~/.nix-profile/share/applications/*.desktop ~/.local/share/applications/

# => Fancy Stuff
[[ -f /usr/local/bin/starship ]] && eval "$(starship init bash)" || \
    PS1='[\u@\h \W]\$ '

[[ -f /usr/bin/figlet && /usr/games/lolcat ]] && \
    figlet bash | lolcat
