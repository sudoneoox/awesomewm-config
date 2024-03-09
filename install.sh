#!/bin/bash

# Set the user's home directory dynamically
HOME_DIR="$(getent passwd "$USER" | cut -d: -f6)"

# Function to install dependencies with yay
install_dep() {
    if ! command -v yay &> /dev/null; then
        echo "yay is not installed. Please install it first."
        exit 1
    fi
    yay -S --needed $1
}

# Install core dependencies
install_dep "nitrogen rofi polybar network-manager-applet pulseaudio pa-applet-git blueman i3lock-color xautolock scrot maim cbatticon xbacklight light brightnessctl pulseaudio-bluetooth clipmenu pywal networkmanager-dmenu calc"
 
# --- Awesme WM Config ---

# Make Awesome Directory if it doesn't exist
mkdir -p "$HOME_DIR/.config/awesome/"


# Backup the existing Awesome config (if any)
if [[ -d "$HOME_DIR/.config/awesome" && ! -d "$HOME_DIR/.config/awesome/backup" ]]; then
    echo "Backing up existing Awesome Config"
    mkdir "$HOME_DIR/.config/awesome/backup/"
    mv "$HOME_DIR/.config/awesome/"* "$HOME_DIR/.config/awesome/backup/"
fi

# make pictures in home directory
mkdir -p "$HOME_DIR/Pictures/"

# Copy this script's awesome configuration directory
echo "Copying this script into the config dir"
cp -r "../awesomewm-config/"* "$HOME_DIR/.config/awesome/"
chmod +x "$HOME_DIR/.config/awesome/lock/lock.sh"

# Move and configure picom
mkdir -p "$HOME_DIR/.config/picom/"
if [[ -d "$HOME_DIR/.config/picom" && ! -d "$HOME_DIR/.config/picom/backup" ]]; then
    echo "Backing up existing Picom Config"
    mkdir "$HOME_DIR/.config/picom/backup"
    mv "$HOME_DIR/.config/picom/"* "$HOME_DIR/.config/picom/backup/"
fi

cp "$HOME_DIR/.config/awesome/picom/conf" "$HOME_DIR/.config/picom/picom.conf"
chmod +x "$HOME_DIR/.config/picom/picom.conf"

# Move and backup Polybar configuration
mkdir -p "$HOME_DIR/.config/polybar/"
if [[ -d "$HOME_DIR/.config/polybar" && ! -d "$HOME_DIR/.config/polybar/backup" ]]; then
    echo "Backing up existing Polybar Config"
    mkdir "$HOME_DIR/.config/polybar/backup"
    mv "$HOME_DIR/.config/polybar/"* "$HOME_DIR/.config/polybar/backup/"
fi

cp -r "$HOME_DIR/.config/awesome/polybar/"* "$HOME_DIR/.config/polybar/"
chmod +x "$HOME_DIR/.config/polybar/launch.sh"
chmod +x "$HOME_DIR/.config/polybar/hack/scripts/" -R

# Setup Nitrogen (assuming your wallpaper is stored somewhere)
# You'll need to adjust the path to your wallpaper
echo "Remember to configure nitrogen with your walpaper you can use my wallpaper thats placed in the wallpaper dir"
echo 'awesome.restart()' | awesome-client
echo "Setup complete!"
