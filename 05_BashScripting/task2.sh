#!/bin/bash

echo "Provide dir patch:"
read path
echo "Provide number of days:"
read days

for file in $(find "$path" -type f -mtime -"$days"); do
    echo "$file"
done
