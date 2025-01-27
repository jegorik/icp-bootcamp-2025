#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "You need to provide 2 arguments for the script."
    exit 1
fi

word="$1"
file="$2"

if [ ! -f "$file" ]; then
    echo "'$file' does not exist."
    exit 1
fi

words=0

words=$(grep -c -w "$word" "$file")

echo "$words"
