export ZSH=~/.zsh

dotfiles=(
    local
)

for file in $dotfiles; do
    file=$ZSH/$file.zsh
    [[ -f $file ]] && source $file
done
