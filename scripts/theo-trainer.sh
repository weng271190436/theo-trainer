#!/bin/bash
# theo-trainer.sh — Play random sounds at irregular intervals to desensitize Theo

export XDG_RUNTIME_DIR=/run/user/$(id -u)
pactl set-default-sink bluez_output.FC_A8_9A_93_3D_FB.1

VIDEOS=(~/Videos/keysound.mp4 ~/Videos/knockdoor.MOV ~/Videos/generated/*.wav)

while true; do
    # Pick a random sound
    FILE=${VIDEOS[$RANDOM % ${#VIDEOS[@]}]}

    # Play it (audio only, exit when done)
    ffplay -nodisp -autoexit "$FILE"

    # Wait random 5-30 minutes (300-1800 seconds)
    WAIT=$((RANDOM % 1500 + 300))
    echo "Next sound in $((WAIT / 60)) minutes..."
    sleep $WAIT
done
