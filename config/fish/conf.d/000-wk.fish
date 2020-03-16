# Inspired by/borrowed from github.com/bitprophet/dotfiles

# Generic "move me to my project dir" function/alias.
set CODE $HOME/Code

function wk
    cd $CODE/$argv 2>/dev/null || cd $CODE/\~$argv 2>/dev/null
end

function _wk_complete
    # find all owner/repo folders in $CODE/
    # and strip the $CODE/ path components to clean it up
    # as well as the leading ~ from git.sr.ht
    find $CODE -mindepth 2 -maxdepth 2 -type d | \
        sed -E "s:^$CODE/~?::" 2>/dev/null
end

complete -c wk -f -a '(_wk_complete)'
