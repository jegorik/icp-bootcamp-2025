#!/bin/bash

target_number=6
rolled_number=0
rolls=0

until [ $rolled_number -eq $target_number ]; do
    ((rolls++))  # Increment the rolls counter
    rolled_number=$((RANDOM % 6 + 1))  # Simulate rolling a six-sided die
    echo "Roll $rolls: You rolled a $rolled_number"
done

echo "Congratulations! You rolled a $target_number after $rolls rolls."
