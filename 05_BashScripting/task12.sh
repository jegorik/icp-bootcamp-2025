#!/bin/bash

while true; do
    clear
    top_output="$(top -b -n 1 | head -n 10)"
    free_output="$(free -h)"
    df_output="$(df -h)"
    ip_output="$(ip addr show)"

    echo "-------------------------------------------------------------------"
    echo "$top_output"
    echo "$free_output"
    echo "$df_output"
    echo "$ip_output"
    echo "--------------------------------------------------------------------"
    echo "Press 's' for snapshot."
    read -t 1 -n 1 key

    if [[ $key = s ]]
    then
        timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
        file_name="snapshot_$timestamp"

        printf "%s\n %s\n %s\n %s\n" "$top_output" "$free_output" "$df_output" "$ip_output" > $file_name
        echo "Snaphot saved."
    fi

    sleep 5
done
