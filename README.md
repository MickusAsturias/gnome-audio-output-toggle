🚀 Installation

1. Paste **toggle-audio.sh** to:
/home/username

2. then in your terminal make the script executable:
chmod +x toggle-audio.sh

3. Edit the SINKS array inside toggle-audio.sh and add your sink names:
pactl list short sinks

Example:
SINKS=(
  "alsa_output.pci-0000_05_00.6.analog-stereo"
  "alsa_output.pci-0000_05_00.1.hdmi-stereo"
  "bluez_output.3C_C9_91_D0_B8_53.1"
)

4. Create a keyboard shortcut in GNOME:
Go to Settings → Keyboard → Custom Shortcuts
Add a new shortcut:
Command: /path/to/toggle-audio.sh
Shortcut: Super + F7 (or any key you want)

🛠 Requirements
pactl (PulseAudio or PipeWire backend)
GNOME desktop environment

note: when you have a new audio device, add the sink name inside **toggle-audio.sh** otherwise it will not cycle
