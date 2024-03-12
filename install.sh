#!/bin/bash

# Dynamically set the user's home directory
HOME_DIR="$(getent passwd "$USER" | cut -d: -f6)"

# Function to install dependencies with yay
install_dep() {
    if ! command -v yay &> /dev/null; then
        echo "yay is not installed. Please install it first."
        exit 1
    fi
    yay -S --needed "$@"
}

# Install core dependencies
core_deps="nitrogen rofi polybar network-manager-applet pulseaudio pa-applet-git blueman i3lock-color xautolock scrot maim cbatticon xbacklight light brightnessctl pulseaudio-bluetooth clipmenu pywal networkmanager-dmenu calc thunar htop ssh-askpass-fullscreen" 
install_dep $core_deps

# Function to handle configuration backups
backup_config() {
    local config_dir="$1"
    local backup_base_dir="$config_dir/backup"
    local backup_dir="$backup_base_dir"
    
    # Check if backup directory exists and create a new one with a timestamp to avoid overwriting
    if [[ -d "$backup_dir" ]]; then
        local timestamp=$(date +%Y%m%d-%H%M%S)
        backup_dir="${backup_base_dir}_${timestamp}"
    fi
    
    echo "Backing up existing config to $backup_dir"
    mkdir -p "$backup_dir"
    mv "$config_dir/"* "$backup_dir/"
}

# --- Awesome WM Config ---

# Ensure Awesome config directory exists
awesome_dir="$HOME_DIR/.config/awesome"
mkdir -p "$awesome_dir"

# Backup the existing Awesome config, if any
if [[ -d "$awesome_dir" && "$(ls -A $awesome_dir)" ]]; then
    backup_config "$awesome_dir"
fi

# Copy this script's awesome configuration directory
echo "Copying AwesomeWM config into the config dir"
cp -r "../awesomewm-config/"* "$awesome_dir/"
chmod +x "$awesome_dir/lock/lock.sh"

# --- Picom Config ---

# Ensure Picom config directory exists
picom_dir="$HOME_DIR/.config/picom"
mkdir -p "$picom_dir"

# Backup the existing Picom config, if any
if [[ -d "$picom_dir" && "$(ls -A $picom_dir)" ]]; then
    backup_config "$picom_dir"
fi

cp "$awesome_dir/picom/conf" "$picom_dir/picom.conf"
chmod +x "$picom_dir/picom.conf"

# --- Polybar Config ---

# Ensure Polybar config directory exists
polybar_dir="$HOME_DIR/.config/polybar"
mkdir -p "$polybar_dir"

# Backup the existing Polybar config, if any
if [[ -d "$polybar_dir" && "$(ls -A $polybar_dir)" ]]; then
    backup_config "$polybar_dir"
fi

cp -r "$awesome_dir/polybar/"* "$polybar_dir/"
chmod +x "$polybar_dir/launch.sh"
chmod +x "$polybar_dir/hack/scripts/" -R

# Setup Nitrogen reminder
echo "Remember to configure Nitrogen with your wallpaper. You can use my wallpaper that's placed in the wallpaper dir."

# Restart AwesomeWM to apply changes
echo 'awesome.restart()' | awesome-client

echo "Setup complete!"
