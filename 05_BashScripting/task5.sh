#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "You need to provide arguments as: <dir1> <dir2> <dir3> ... <path where to copy>"
    exit 1
fi

dirs=("$@")

backup_dir="${dirs[-1]}"

if [ ! -d "$backup_dir" ]; then
    echo "$backup_dir is not a valid directory."
    exit 1
fi

for dir in "${dirs[@]:0:$#-1}"; do
    if [ -d "$dir" ]; then
        cp -rf "$dir" "$backup_dir"
        echo "'$dir' copied to '$backup_dir'."
    else
        echo "'$dir': issue with copying."
    fi
done
