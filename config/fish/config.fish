set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
set -q XDG_DATA_HOME; or set XDG_DATA_HOME ~/.local/share

function try_prepend --description 'try_prepend PATH /foo/bar'
    contains $argv[2] $$argv[1]; or set -p $argv[1] $argv[2]
end

# reset PATH to defaults
set PATH /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin
try_prepend PATH $HOME/.cargo/bin
try_prepend PATH $HOME/.local/bin

if type -q direnv
    direnv hook fish | source
end

if type -q dircolors
    eval (dircolors --c-shell ~/.config/dircolors/dircolors)
end

if type -q starship
    starship init fish | source
end

if test -d $XDG_DATA_HOME/asdf-core
    set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
    set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf
    set -gx ASDF_DEFAULT_TOOL_VERSIONS_FILENAME $XDG_CONFIG_HOME/asdf/tool-versions
    try_prepend fish_complete_path $XDG_DATA_HOME/asdf-core/completions
    source $XDG_DATA_HOME/asdf-core/asdf.fish
end

set -gx GO111MODULE on

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
alias dnf 'command sudo dnf'

alias gs 'git st'
alias gar 'git add -A (git root)'
alias gci 'git commit'
alias gd 'git diff'
alias gl 'git lg'
alias vim nvim
abbr -a g git
abbr -a gti git

alias docker-gc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc'

# auto-install fisher and plugins, with plugins stored in ~/.config/fish/plugged
set -g fisher_path $XDG_CONFIG_HOME/fish/plugged
try_prepend fish_function_path $fisher_path/functions
try_prepend fish_complete_path $fisher_path/completions

if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/plugged/functions/fisher.fish
    source $XDG_CONFIG_HOME/fish/plugged/functions/fisher.fish
    fish -c fisher
end

for f in $fisher_path/conf.d/*.fish
    builtin source $f 2> /dev/null
end

test -f ~/.config/fish/local.config.fish; and source ~/.config/fish/local.config.fish

# TODO: Get these out of here
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
