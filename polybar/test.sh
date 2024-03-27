#!/bin/bash

# Define the home directory
home_dir="$HOME"

# Define the current working directory
current_dir=$(pwd)

# Define the AwesomeWM Polybar configuration directory
awesome_polybar_dir="$home_dir/.config/awesome/polybar"

# Define the standard Polybar configuration directory
polybar_config_dir="$home_dir/.config/polybar"

# Function to safely remove and copy contents
safe_sync() {
    local source_dir="$1"
    local dest_dir="$2"

    # Ensure the destination directory exists
    mkdir -p "$dest_dir"

    # Remove contents of the destination directory safely
    find "$dest_dir" -mindepth 1 -delete

    # Copy the contents from source to destination
    cp -r "$source_dir/"* "$dest_dir/"
}

# Check if the script is executed within the AwesomeWM configuration directory
if [[ "$current_dir" == "$home_dir/.config/awesome" ]]; then
    # Sync from AwesomeWM Polybar to standard Polybar configuration
    echo "Syncing from AwesomeWM Polybar to standard Polybar configuration..."
    safe_sync "$awesome_polybar_dir" "$polybar_config_dir"
else
    # Sync from standard Polybar configuration to AwesomeWM Polybar
    echo "Syncing from standard Polybar configuration to AwesomeWM Polybar..."
    safe_sync "$polybar_config_dir" "$awesome_polybar_dir"
fi

echo "Synchronization complete."
