function ensure-git-email --description "Verifies git repositories have the proper user.email"
    set repo $argv[1]; or set repo (pwd)

    if test ! -d "$repo/.git"
        echo $argv is not a git repository
        return 1
    end

    if string match -e -q -- khan $repo
        git config --file $repo/.git/config --add user.email 'alexvidal@khanacademy.org'
    else
        git config --file $repo/.git/config --add user.email 'alex@heyviddy.com'
    end
end

complete -c ensure-git-email -f -a '(__fish_complete_directories (commandline -ct))'
