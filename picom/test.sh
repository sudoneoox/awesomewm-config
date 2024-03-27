#!/bin/bash

# Define the home directory
home_dir="$HOME"

# Define the current working directory
current_dir=$(pwd)

# Define the target directory for the Picom configuration within the AwesomeWM directory
awesome_picom_dir="$home_dir/.config/awesome/picom"

# Define the actual Picom configuration directory
picom_config_dir="$home_dir/.config/picom"

# Check if the script is executed within the AwesomeWM configuration directory
if [[ "$current_dir" == "$home_dir/.config/awesome" ]]; then
    # Ensure the target directory exists
    mkdir -p "$awesome_picom_dir"
    
    # Remove everything in the target Picom directory within AwesomeWM
    rm -rf "$awesome_picom_dir/*"
    
    # Copy the Picom configuration to the AwesomeWM directory
    cp -r "$picom_config_dir/"* "$awesome_picom_dir/"
else
    echo "This script should be run from the .config/awesome directory."
fi
