export ZSH=~/.zsh

# compsys initialization
autoload -U compinit
compinit

# use a completion cache, stored in completion.cache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH/data/completion.cache

# Add brew installed zsh completion funcs to $fpath
fpath=(/usr/local/share/zsh/site-functions/ $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

# Enable completion functions in .zsh/completion
fpath=($ZSH/completion $fpath)

dotfiles=(
    exports
    platform
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
