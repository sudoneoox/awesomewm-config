#!/bin/bash

# Check the number of connected monitors
monitor_count=$(xrandr --listmonitors | grep -c " connected")

if [ $monitor_count -gt 1 ]; then
    # If more than one monitor is detected, run tail command
    tail -f ~/.config/polybar/hack/scripts/polypomo/polypomo.status
    sed -i '/module\/polypomo/{n;s/tail = true/interval = 10\n&/}' ~/.config/polybar/hack/user_modules.ini
else
    
    # If only one monitor is detected, run polypomo
    ~/.config/polybar/hack/scripts/polypomo/polypomo
    sed -i '/interval = 10/d' ~/.config/polybar/hack/user_modules.ini
fi