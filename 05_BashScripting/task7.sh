#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Wrong usage! Please provide exactly two numbers."
    exit 1
fi

n1="$1"
n2="$2"

sum=$(($n1 + $n2))
echo "$sum"

while true; do
    echo "Enter your number: "
    read user_input

    user_input_int=$((user_input))

    if (( user_input_int > sum )); then
        echo "Too big!"
    elif (( user_input_int < sum )); then
        echo "Too small!"
    elif (( user_input_int == sum )); then
        echo "Bingo!"
        break
    fi
done
