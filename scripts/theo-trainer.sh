#!/bin/bash
# theo-trainer.sh — Play random sounds at irregular intervals to desensitize Theo

export XDG_RUNTIME_DIR=/run/user/$(id -u)
pactl set-default-sink bluez_output.FC_A8_9A_93_3D_FB.1

# Quiet hours (no sounds during sleep)
QUIET_START=23  # 11 PM
QUIET_END=8     # 8 AM

VIDEOS=(~/Videos/* ~/Videos/generated/*.wav)

while true; do
    HOUR=$(date +%H)

    # Skip quiet hours
    if [ "$HOUR" -ge "$QUIET_START" ] || [ "$HOUR" -lt "$QUIET_END" ]; then
        echo "Quiet hours (${QUIET_START}:00-${QUIET_END}:00). Sleeping 30 min..."
        sleep 1800
        continue
    fi

    # Pick a random sound
    FILE=${VIDEOS[$RANDOM % ${#VIDEOS[@]}]}

    # Play it (audio only, exit when done)
    ffplay -nodisp -autoexit "$FILE"

    # Wait random 5-30 minutes (300-1800 seconds)
    WAIT=$((RANDOM % 1500 + 300))
    echo "Next sound in $((WAIT / 60)) minutes..."
    sleep $WAIT
done
