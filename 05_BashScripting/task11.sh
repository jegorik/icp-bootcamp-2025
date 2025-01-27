#!/bin/bash

source_dir="$1"
backup_dir="$2"
backup_type="$3"

if [ "$#" -lt 3 ]; then
    echo "Provide arguments as <source_dir> <backup_dir> <type_of_backup('full' or 'incremental')>"
    exit 1
fi

if [ ! -d "$source_dir" ]; then
    echo "$source_dir not exist."
    exit 1
fi

mkdir -p "$backup_dir"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
backup_name="backup_$timestamp"

if [ "$backup_type" == "full" ]; then
    rsync -a --delete "$source_dir/" "$backup_dir/$backup_name/"
elif [ "$backup_type" == "incremental" ]; then
    #I have used chat_gpt to create a correct logic for that operation. This one is clever: (ls -1t "$backup_dir" | head -n 1).
    rsync -a --delete --link-dest="$backup_dir/$(ls -1t "$backup_dir" | head -n 1)" "$source_dir/" "$backup_dir/$backup_name/"
fi

echo "Backup complete."

#And for that one too.
backup_counts=$(ls -1 "$backup_dir" | wc -l)

if ((backup_counts > 5)); then
    oldest_backup=$(ls -1t "$backup_dir" | tail -n 1)
    rm -rf "$backup_dir/$oldest_backup"
fi
