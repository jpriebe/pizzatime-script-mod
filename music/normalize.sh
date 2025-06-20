#!/usr/bin/env bash

# Directory containing MP3 files
INPUT_DIR="./mp3"
OUTPUT_DIR="./mp3-normalized"
mkdir -p "$OUTPUT_DIR"

# Temp file to store loudness measurements
TMP_STATS=$(mktemp)

# Step 1: Measure loudness
echo "Measuring loudness..."
for f in "$INPUT_DIR"/*.mp3; do
    ffmpeg -hide_banner -i "$f" -af loudnorm=print_format=json -f null - 2>&1 | \
        awk '/^{/,/^}/{ print }' >> "$TMP_STATS"
done

# Step 2: Calculate average Integrated Loudness (I)
echo "Calculating average loudness..."
AVG_I=$(jq -s 'map(.input_i | tonumber) | add / length' "$TMP_STATS")

echo "Average Integrated Loudness: $AVG_I LUFS"

# Step 3: Normalize each file to the average I
echo "Normalizing files..."
for f in "$INPUT_DIR"/*.mp3; do
    base=$(basename "$f")
    ffmpeg -hide_banner -i "$f" \
        -af "loudnorm=I=$AVG_I:TP=-1.5:LRA=11" \
        -ar 44100 -y "$OUTPUT_DIR/$base"
done

# Cleanup
rm "$TMP_STATS"
echo "Done. Normalized files are in $OUTPUT_DIR"

