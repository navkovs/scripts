#!/bin/bash

# Bind to a hotkey.
# Switch between headphones and speakers as audio sink.

# Define Headphones and Speakers
devHeadphones=$(pactl list short sinks | grep "FiiO" | cut -c -2 | tr -d " \t")
devSpeakers=$(pactl list short sinks | grep "pci-0000_2a" | cut -c -2  | tr -d " \t")
devSuspended=$(pactl list short sinks | grep "\(FiiO\|pci-0000_2a\).\+\(SUSPENDED\|IDLE\)" | cut -c -2  | tr -d " \t")

# Check if Headphones are not used, if true reuse devSuspended to set new
# default listening device in next step.
if [ "$devSpeakers" == "$devSuspended" ]; then
    devSuspended="$devSpeakers"
else
    devSuspended="$devHeadphones"
fi

# Use devSuspended from before to set new default and move all streams to it.
pacmd set-default-sink "$devSuspended"
pactl list short sink-inputs|while read stream; do
    streamId=$(echo $stream|cut '-d ' -f1)
    pactl move-sink-input "$streamId" "$devSuspended"
done
