export ZSH=~/.zsh

dotfiles=(
    exports
    platform
    completion
    aliases
    history
    python
    ruby
    wk
    prompt
    local
)

for file in $dotfiles; do
    file=$ZSH/$file
    [[ -f $file ]] && source $file
done