#alias sudo='doas'
alias apt='sudo nala'
alias pkgup='sudo nala upgrade'
alias fishrc="vim ~/.config/fish/config.fish"
alias deb='deb-get'
alias ls='lsd'
alias lt='lsd --tree'
alias cat='bat'

figlet fish -c | lolcat
colorscript -r
#starship init fish | source
