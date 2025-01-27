#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "You need to provide 2 arguments for the script."
    exit 1
elif  ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "First argument must be digit."
    exit 1
elif [[ "$2" != "C" && "$2" != "F" ]]; then
    echo "Second argument must be 'C' or 'F'."
    exit 1
fi

temperature="$1"
temp_unit="$2"

case "$temp_unit" in
    C)
        farenheit=$(( 18 * $temperature + 325 ))
        echo "The temperature in Fahrenheit is ${farenheit:0: -1}" ;;
    F)
        celsius=$((($temperature - 32) * 5/9))
        echo "The temperature in Celsius is ${celsius}" ;;
esac
