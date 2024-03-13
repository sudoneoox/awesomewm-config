#!/bin/bash

# Function to check for multiple screens
has_multiple_screens() {
  xrandr | grep " connected" | wc -l | grep -q "^[2-9]"
}

# Get user-provided wallpaper path
wallpaper_file="$1"

# Default wallpaper directory (adjust if needed)
wallpaper_dir="$HOME_DIR/.config/awesome/Wallpapers/"

# Check for multiple screens
if has_multiple_screens; then
  # Use feh for multi-screen

  # Use provided wallpaper or default directory
  if [[ ! -z "$wallpaper_file" ]] && [[ -f "$wallpaper_file" ]]; then
    feh --bg-scale "$wallpaper_file"
  else
    feh --bg-scale "$wallpaper_dir"/*
  fi
else
  # Use nitrogen for single screen

  # Use provided wallpaper or default wallpaper file
  if [[ ! -z "$wallpaper_file" ]] && [[ -f "$wallpaper_file" ]]; then
    nitrogen --set-zoom-fill --restore --head=0 --save "$wallpaper_file"
  else
    nitrogen --set-zoom-fill --restore --head=0 --save "$wallpaper_dir/forest.png"  # Replace with your default
  fi
fi
