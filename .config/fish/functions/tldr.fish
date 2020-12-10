function tldr --description "fetch simplified examples from cht.sh" --argument-names "topic"
    curl cht.sh/$topic
end
