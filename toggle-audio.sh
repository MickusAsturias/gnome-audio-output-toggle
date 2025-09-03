#!/bin/bash

SINKS=(
  "alsa_output.pci-0000_05_00.6.analog-stereo"
  "alsa_output.pci-0000_05_00.1.hdmi-stereo"
  "bluez_output.3C_C9_91_D0_B8_53.1"
  "bluez_output.F4_B6_2D_DD_27_E2.1"
)

CURRENT_SINK=$(/usr/bin/pactl get-default-sink)
AVAILABLE_SINKS=$(/usr/bin/pactl list short sinks | awk '{print $2}')

# Function to check if a sink exists
is_sink_available() {
  for sink in $AVAILABLE_SINKS; do
    if [[ "$sink" == "$1" ]]; then
      return 0
    fi
  done
  return 1
}

# Find the current sink index
NEXT_INDEX=0
for i in "${!SINKS[@]}"; do
  if [[ "${SINKS[$i]}" == "$CURRENT_SINK" ]]; then
    NEXT_INDEX=$(( (i + 1) % ${#SINKS[@]} ))
    break
  fi
done

# Loop until we find an available sink
for ((count=0; count<${#SINKS[@]}; count++)); do
  if is_sink_available "${SINKS[$NEXT_INDEX]}"; then
    /usr/bin/pactl set-default-sink "${SINKS[$NEXT_INDEX]}"
    exit 0
  fi
  NEXT_INDEX=$(( (NEXT_INDEX + 1) % ${#SINKS[@]} ))
done

# If no sink is available, fallback to the first sink
/usr/bin/pactl set-default-sink "${SINKS[0]}"

