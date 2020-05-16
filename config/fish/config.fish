function path_add
    contains $argv $PATH; or set -p PATH $argv
end

path_add /usr/local/sbin
path_add /usr/local/bin
path_add $HOME/.cargo/bin
path_add $HOME/go/bin
path_add $HOME/.local/bin

set -gx GO111MODULE on

set -gx PYENV_ROOT ~/Code/pyenv/pyenv
path_add $PYENV_ROOT/bin

if type -q direnv
    direnv hook fish | source
end

if type -q dircolors
    eval (dircolors --c-shell ~/.config/dircolors/dircolors)
end

if type -q pyenv
    pyenv init - | source
end

# auto-install fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
