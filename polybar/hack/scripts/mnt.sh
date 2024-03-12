#!/usr/bin/env bash

## Author: Diego Coronado
## Description: Mount devices using rofi

dir="$HOME/.config/polybar/hack/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Get device list (ignoring loop devices and the main disk, adjust as needed)
devices=$(lsblk -lp -o NAME,LABEL,SIZE,MOUNTPOINT | grep -v "loop" | awk '$4=="" {print $1, ($2 ? "(" $2 ") " : "") "(" $3 ")"}')

# No devices found
if [ -z "$devices" ]; then
    rofi -no-config -theme "$dir/powermenu.rasi" -e "No devices found to mount."
    exit 1
fi

# Use rofi to select a device
chosen=$(echo -e "$devices" | $rofi_command -p "Select device to mount: " -dmenu -selected-row 0)

# Extract the device path
device=$(echo $chosen | awk '{print $1}')

# Confirmation
confirm_mount() {
    rofi -dmenu\
    -no-config\
    -i\
    -no-fixed-num-lines\
    -p "Mount $device? [yes/no]: "\
    -theme $dir/confirm.rasi
}

# message
msg() {
    rofi -no-config -theme "$dir/message.rasi" -e "Available Options - yes / y / no / n"
}

if [ ! -z "$device" ]; then
    ans=$(confirm_mount &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
        # Extract a simplified device name to use as the directory name
        device_name=$(echo $device | tr -d '/' | tr -d '[:punct:]')
        
        # Define mount point (create if it doesn't exist)
        mount_point="$HOME/diskname/$device_name"
        mkdir -p "$mount_point"
        
        # Attempt to mount
        if SUDO_ASKPASS=/usr/lib/openssh/ssh-askpass-fullscreen sudo -A mount "$device" "$mount_point"; then
            rofi -no-config -theme "$dir/message.rasi" -e "Mounted $device at $mount_point"
        else
            rofi -no-config -theme "$dir/message.rasi" -e "Failed to mount $device."
        fi
        elif [[ $ans == "no" || $ans == "n" || $ans == "NO" || $ans == "N" ]]; then
        
        exit 0
    else
        msg
    fi
else
    rofi -no-config -theme "$dir/message.rasi" -e "No device selected."
fi