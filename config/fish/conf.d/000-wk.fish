# Inspired by/borrowed from github.com/bitprophet/dotfiles

# Generic "move me to my project dir" function/alias.
set CODE $HOME/Code

function wk
    cd $CODE/*/$argv
end

function _wk_complete
    # find all owner/repo folders in $CODE/
    # and strip the first three path components
    find $CODE -mindepth 3 -maxdepth 3 -type d | \
        sed -E "s:^$CODE/[^/]+/::" 2>/dev/null
end

complete -c wk -f -a '(_wk_complete)'
