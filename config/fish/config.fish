set poetry_bin $HOME/.poetry/bin
set rust_bin $HOME/.cargo/bin
set go_bin $HOME/go/bin
set home_path $HOME/.local/bin:$HOME/bin
set local_path /usr/local/bin:/usr/local/sbin

set -gx PATH $rust_bin $go_bin $poetry_bin $home_path $local_path $PATH
set -gx GO111MODULE on

if type -q direnv
    direnv hook fish | source
end

if type -q dircolors
    eval (dircolors --c-shell ~/.config/dircolors/dircolors)
end
