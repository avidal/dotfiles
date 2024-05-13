# we don't need to see the greeting anymore
set fish_greeting;

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME ~/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME ~/.local/share

# put various tools in xdg instead of splatting my homedir
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx AWS_HOME $XDG_CONFIG_HOME/aws
set -gx KUBECTL_HOME $XDG_CONFIG_HOME/kubectl

# if we have homebrew installed, let's push its path and some optional extras
if type -q /opt/homebrew/bin/brew

    set -l BREWPATH /opt/homebrew

    fish_add_path $BREWPATH/opt/coreutils/libexec/gnubin
    fish_add_path $BREWPATH/opt/grep/libexec/gnubin
    fish_add_path $BREWPATH/sbin
    fish_add_path $BREWPATH/bin
end

fish_add_path $CARGO_HOME/bin
fish_add_path $HOME/.local/bin

# TODO: move this stuff to config.d/work.local.fish or something
set -gx DATADOG_ROOT ~/Code/datadog
set -gx GOPRIVATE github.com/DataDog
fish_add_path $DATADOG_ROOT/devtools/bin

# TODO: move this stuff to config.d/aws.fish
set -gx AWS_CONFIG_FILE $AWS_HOME/config
set -gx AWS_SHARED_CREDENTIALS_FILE $AWS_HOME/credentials
set -gx AWS_VAULT_KEYCHAIN_NAME login
set -gx AWS_SESSION_TTL 24h
set -gx AWS_ASSUME_ROLE_TTL 1h

set -gx KUBECONFIG $KUBECTL_HOME/config
set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx GPG_TTY (tty)

if type -q direnv
    direnv hook fish | source
end

if type -q dircolors && test -f ~/.config/dircolors/dircolors
    eval (dircolors --c-shell ~/.config/dircolors/dircolors)
end

if type -q mise
    mise activate fish | source

    # if we don't have the completions installed, add them now
    if ! test -f $HOME/.config/fish/completions/mise.fish
        mise completions fish > $HOME/.config/fish/completions/mise.fish
    end
end

set -gx EDITOR nvim

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
alias dnf 'command sudo /usr/bin/dnf'

alias gs 'git st'
alias gar 'git add -A (git root)'
alias gci 'git commit'
alias gd 'git diff'
alias gl 'git lg'
alias vim nvim

# autoexpand g and gti to git
abbr -a g git
abbr -a gti git

test -f ~/.config/fish/local.config.fish; and source ~/.config/fish/local.config.fish

# TODO: Get these out of here
function clone-git --description "clone-git <example.com> <user/repo>"
    set host $argv[1]; set --erase argv[1];
    set repo $argv[1]; set --erase argv[1];
    git clone git@$host:$repo $HOME/Code/$repo $argv
end

function clone-github --description "clone-github <user/repo>"
    set repo $argv[1]; and set --erase argv[1];
    git clone git@github.com:$repo $HOME/Code/$repo $argv
end

function clone-work --description "clone-work <repo>"
    set repo $argv[1]; and set --erase argv[1];
    git clone git@github.com:DataDog/$repo $HOME/Code/datadog/$repo $argv
end

# no file completions for these commands
complete -c clone-github -c clone-git -c clone-work -f
