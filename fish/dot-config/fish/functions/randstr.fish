function randstr --description "randstr [length|default=32]"
    if [ (count $argv) -eq 0 ];
        set strlen 32;
    else
        set strlen $argv[1];
    end
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $strlen | head -n 1
end

complete -c randstr -f
