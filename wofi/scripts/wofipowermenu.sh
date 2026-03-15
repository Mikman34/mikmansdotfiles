#!/bin/bash

# Check if Wofi is already running
if pgrep -x wofi > /dev/null; then
    # Close it
    pkill -x wofi
else
    # Launch Wofi and capture selection
    choice=$(wofi --show dmenu --prompt "Power Menu:" --lines 7 --width 400 --height 450 --style /home/alex/.config/wofi/powermenu.css <<EOF
  Lock
  Suspend
󰍃  Log out
󰜉  Reboot
󰍛  Reboot to UEFI
󰑓  Hard reboot
⏻  Shutdown
EOF
)

    # Trim whitespace
    choice=$(echo "$choice" | xargs)

    # Close if nothing selected (Esc or click outside)
    [[ -z "$choice" ]] && exit 0

    # Execute based on selection
    case $choice in
        *Lock)
            swaylock
            ;;
        *Suspend)
            systemctl suspend
            ;;
        *Log\ out)
            hyprctl dispatch exit
            ;;
        *Reboot)
            systemctl reboot
            ;;
        *Reboot\ to\ UEFI)
            systemctl reboot --firmware-setup
            ;;
        *Hard\ reboot)
            pkexec sh -c 'echo b > /proc/sysrq-trigger'
            ;;
        *Shutdown)
            systemctl poweroff
            ;;
        *)
            exit 0
            ;;
    esac
fi
