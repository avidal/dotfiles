alias la 'ls -al'
alias ll 'ls -l'

function lsd -d 'List only directories'
    ls -d */ | sed -Ee 's,/+$,,'
end

alias ungron 'gron -u'
alias svim 'sudo nvim'
alias stail 'sudo tail'
alias rmpyc 'rm **/*.pyc'
alias ports 'sudo lsof -i -P -sTCP:LISTEN'

alias gs 'git st'
alias gar 'git add -A (git root)'
alias gci 'git commit'
alias gd 'git diff'
alias gl 'git lg'
abbr -a g git
abbr -a gti git

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
