#!/bin/bash

{
    start() {
        cd "$(dirname "$0")" || exit
        screen -d -m -S STAR ./star
    }
    running() {
        screen -ls | grep -q "STAR"
    }
    while true; do
        attempts=0
        while [ $attempts -lt 5 ]; do
            if ! running; then
                echo "Attempting to start STAR (Attempt $((attempts+1)) of 5)"
                chmod 777 *
                ulimit -n 999999
                start
                sleep 1s
            else
                echo "STAR is running."
                break
            fi
            attempts=$((attempts+1))
        done
        if ! running; then
            echo "AN ERROR OCCURRED WHEN STARTING STAR"
            ./star
            echo "CHECK ERROR ABOVE"
            echo "Sleeping for 15s before trying again."
            sleep 15s
        fi
        sleep 1s
    done
}