export ZSH=~/.zsh

dotfiles=(
    exports
    platform
    completion
    aliases
    history
    tmux
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

for file in $ZSH/plugins/*.zsh; do
    source $file
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
