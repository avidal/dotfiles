function clone-git --description "clone-git <example.com> <user/repo>"
    set host $argv[1]; set --erase argv[1];
    set repo $argv[1]; set --erase argv[1];
    git clone git@$host:$repo $HOME/Code/$repo $argv
    git config --file $HOME/Code/$repo/.git/config --add user.email 'alex@heyviddy.com'
end

function clone-github --description "clone-github <user/repo>"
    set repo $argv[1]; and set --erase argv[1];
    git clone git@github.com:$repo $HOME/Code/$repo $argv
    git config --file $HOME/Code/$repo/.git/config --add user.email 'alex@heyviddy.com'
end

function clone-work --description "clone-work <repo>"
    set repo $argv[1]; and set --erase argv[1];
    git clone git@github.com:khan/$repo $HOME/Code/khan/$repo $argv
    git config --file $HOME/Code/khan/$repo/.git/config --add user.email 'alexvidal@khanacademy.org'
end

# no file completions for these commands
complete -f -c clone-github -c clone-git -c clone-work
