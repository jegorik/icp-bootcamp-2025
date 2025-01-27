#!/bin/bash

path=$1

if [ -d "$path" ]; then
    du -sh "$path"
else
    echo "Directory don't exist"
fi
