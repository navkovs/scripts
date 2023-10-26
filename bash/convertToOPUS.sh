#!/bin/bash

# Convert all files in a dir and child dir from the specified type to OPUS.
# Preserve the original files inside all dir.

# Check if dir specified
if [ $# -eq 2 ]
    then
        echo "Usage example: ./convertToOPUS.sh mp3 dir"
        echo "Would convert all mp3 from dir to OPUS 96."
        exit $E_BADARGS
fi

# Enable ** and globs case-insensitivity
shopt -s globstar nocaseglob nocasematch

# libopus quality level: higher=better
for i in "$2"/**/*.$1 ; do
    ffmpeg -y -i "$i" -c:a libopus -ab 96K "${i%.*}.opus"
done
