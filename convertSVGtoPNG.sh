#!/bin/sh

# Convert all files in a dir from SVG to PNG.
# Preserve the original files.

for file in *.svg
do
     /usr/bin/rsvg-convert "${file}" >  "${file}.png"
done
