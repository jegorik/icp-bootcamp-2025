#!/bin/bash

hello () {
  echo "Type your name."
  read name
  echo "Hello $name. Let's start."
}

start_trivia () {
    answers_sum=0
    declare -A questions
    questions=(
        ["1 + 1 = ?"]="2"
        ["3 + 5 = ?"]="8"
        ["4 - 1 = ?"]="3"
        ["2 * 3 = ?"]="6"
        ["6 / 2 = ?"]="3"
    )

    for question in "${!questions[@]}"; do
        echo "$question"
        read -p "Your answer: " user_input

        if [[ "$user_input" == "${questions[$question]}" ]]; then
            (( answers_sum++ ))
        fi
    done
    echo "Your score: $answers_sum out of ${#questions[@]}"
}

hello
start_trivia
