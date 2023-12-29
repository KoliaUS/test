#!/bin/bash

# Získejte PID terminálu
terminal_pid=$(ps -A | grep Terminal | grep -v grep | awk '{print $1}')

# Získejte seznam běžících procesů kromě terminálu
running_processes=$(ps -A -o pid,command | grep -v "grep" | grep -v "$0" | grep -v "$terminal_pid")

# Ukončení všech běžících procesů kromě terminálu
while read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    echo "Killing process $pid"
    kill -9 "$pid"
done <<< "$running_processes"

echo "All processes killed except for Terminal."
