#!/bin/bash
# generate-variations.sh — Create sound variations for Theo training
# Usage: ./generate-variations.sh

SRC=~/Videos
OUT=~/Videos/generated
mkdir -p "$OUT"

COUNT=10  # variations per source file

for file in "$SRC"/keysound.mp4 "$SRC"/knockdoor.MOV; do
    name=$(basename "${file%.*}")
    echo "=== Generating variations for $name ==="

    for i in $(seq 1 $COUNT); do
        pitch=$(awk "BEGIN{printf \"%.2f\", 0.85 + (${RANDOM} % 31) / 100}")
        tempo=$(awk "BEGIN{printf \"%.2f\", 0.90 + (${RANDOM} % 21) / 100}")

        effect=$((RANDOM % 4))
        case $effect in
            0) # Pitch + tempo only
                filter="asetrate=44100*${pitch},atempo=${tempo}"
                tag="pt";;
            1) # Echo (different room feel)
                delay=$((RANDOM % 80 + 20))
                decay=$(awk "BEGIN{printf \"%.1f\", 0.2 + (${RANDOM} % 5) / 10}")
                filter="asetrate=44100*${pitch},atempo=${tempo},aecho=0.8:0.88:${delay}:${decay}"
                tag="echo";;
            2) # Volume variation
                vol=$(awk "BEGIN{printf \"%.1f\", 0.6 + (${RANDOM} % 9) / 10}")
                filter="asetrate=44100*${pitch},atempo=${tempo},volume=${vol}"
                tag="vol";;
            3) # Random delay before sound
                delay_ms=$((RANDOM % 900 + 100))
                filter="adelay=${delay_ms}|${delay_ms},asetrate=44100*${pitch},atempo=${tempo}"
                tag="delay";;
        esac

        ffmpeg -i "$file" -af "$filter" -vn "$OUT/${name}_${tag}_v${i}.wav" -y 2>/dev/null
        echo "  [$i/$COUNT] ${name}_${tag}_v${i}.wav (pitch=$pitch tempo=$tempo effect=$tag)"
    done
done

total=$(ls "$OUT"/*.wav 2>/dev/null | wc -l)
echo "Done! Generated $total variations in $OUT"
