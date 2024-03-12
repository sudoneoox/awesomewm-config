#!/usr/bin/env bash

## Author: Diego Coronado
## Description: Quick filesystem access using rofi

dir="$HOME/.config/polybar/hack/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Predefined paths
declare -A paths=(
    ["Documents"]="$HOME/Documents"
    ["Downloads"]="$HOME/Downloads"
    ["Pictures"]="$HOME/Pictures"
    ["Music"]="$HOME/Music"
    ["Videos"]="$HOME/Videos"
)

# Dynamically add directories from ~/diskname/
diskname_dir="$HOME/diskname"
if [ -d "$diskname_dir" ]; then
    for dir in "$diskname_dir"/*/; do
        dir_name=$(basename "$dir")
        paths["$dir_name"]="$dir"
    done
fi

# Generate the menu string
menu=""
for label in "${!paths[@]}"; do
    menu+="mount: $label\n"
done

# Launch rofi to select a path
selected=$(echo -e "$menu" | $rofi_command -p "Open:" -dmenu -selected-row 0)

# Open Thunar at the selected path
if [ -n "$selected" ]; then
    thunar "${paths[$selected]}"
fi
