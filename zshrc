export ZSH=~/.zsh

# compsys initialization
autoload -Uz compinit

typeset -i updated_at=$(\
    date +'%j' -r ~/.zcompdump 2>/dev/null || \
    stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null \
)
if [ $(date '+%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

# use a completion cache, stored in completion.cache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH/data/completion.cache

zmodload -i zsh/complist

for file in $ZSH/autoload/*.zsh; do
    source $file
done

dotfiles=(
    exports
    platform
    aliases
    history
    python
    wk
    local
)

for file in $dotfiles; do
    file=$ZSH/$file
    [[ -f $file ]] && source $file
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcuu1]" history-substring-search-up

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
