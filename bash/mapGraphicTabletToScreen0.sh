#!/bin/bash

# If "Wacom One by Wacom" is connected to Computer, map input to the main
# monitor only. In this case the HDMI-A-0 output of the GPU.

# Define Graphic Tablet IDs.
getStylus=$(xinput | grep "Wacom One by Wacom S Pen stylus" | cut -c 55-56 | xargs)
getEraser=$(xinput | grep "Wacom One by Wacom S Pen eraser" | cut -c 55-56 | xargs)

if [ -z "$getStylus" ] &&  [ -z "$getEraser" ]; then
    echo "Tablet not connected!"
    break
fi

# Since we are here, tablet has to be connected.
# Map to primary display.
xinput map-to-output "$getStylus" HDMI-A-0
xinput map-to-output "$getEraser" HDMI-A-0

# Set custom pressure curve.
xsetwacom set "$getStylus" PressureCurve "10 40 60 90"

