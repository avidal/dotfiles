alias ls='ls --color=auto'
alias la='ls -al'
alias ll='ls -l'

alias ungron='gron -u'

alias svim='sudo vim'
alias stail='sudo tail'
alias svs='sudo supervisorctl'

# Alias package managers to always use sudo
alias apt-get='sudo apt-get'
alias apt-cache='sudo apt-cache'
alias apt-file='sudo apt-file'
alias apt='sudo apt'
alias pacman='sudo pacman'
alias dnf='sudo dnf'

alias rmpyc='rm **/*.pyc'
alias ports='sudo lsof -i -P -sTCP:LISTEN'

alias gs='git st'
alias gar='git add -A (git root)'
alias gci='git commit'
alias gd='git diff'
alias gl='git lg'
alias g='git'
alias gti='git'

alias docker-gc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc'

alias vim=nvim

# generates a random string, specify length as the first argument (default is
# 32)
function randstr
    if [ (count $argv) -eq 0 ];
        set strlen 32;
    else
        set strlen $argv[1];
    end
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $strlen | head -n 1
end
