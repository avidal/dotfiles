function clone-git --description "clone-git <example.com> <user/repo>"
    set host $argv[1]; set --erase argv[1];
    set repo $argv[1]; set --erase argv[1];
    git clone git@$host:$repo $HOME/Code/$host/$repo $argv
end

function clone-github --description "clone-github <user/repo>"
    set repo $argv[1]; and set --erase argv[1];
    git clone git@github.com:$repo $HOME/Code/github.com/$repo $argv
end

# no file completions for these commands
complete -f -c clone-github -c clone-git
