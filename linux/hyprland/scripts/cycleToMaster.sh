#!/bin/bash

ACTIVE_WINDOW_IS_FULLSCREEN=$(hyprctl activewindow -j | jq -r '.fullscreen')

if [[ "$ACTIVE_WINDOW_IS_FULLSCREEN" == "true" ]]; then
    hyprctl dispatch fullscreen 1
fi

ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.address')
hyprctl dispatch layoutmsg focusmaster master
MASTER_WINDOW=$(hyprctl activewindow -j | jq -r '.address')

if [[ "$ACTIVE_WINDOW" == "$MASTER_WINDOW" ]]; then
    exit
fi

hyprctl dispatch focuscurrentorlast

PREV_WINDOW=""
COUNTER=0
MAX_ITERATIONS=100

while true; do
    if [[ "$PREV_WINDOW" == "$MASTER_WINDOW" ]]; then
        break
    elif [[ $COUNTER -ge $MAX_ITERATIONS ]]; then
        hyprctl notify -1 10000 0 "Loop limit reached, exiting"
        break
    fi
    
    hyprctl dispatch layoutmsg swapprev
    hyprctl dispatch layoutmsg cyclenext
    PREV_WINDOW=$(hyprctl activewindow -j | jq -r '.address')
    hyprctl dispatch layoutmsg cycleprev

    COUNTER=$((COUNTER + 1))
done
