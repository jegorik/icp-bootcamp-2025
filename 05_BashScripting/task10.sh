#!/bin/bash

check_log () {
    while true; do
        grep -w "ERROR" test_log
        sleep 1m
    done
}

check_log
