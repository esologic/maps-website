#!/bin/bash

# Ensure exiftran is installed
if ! command -v exiftran &>/dev/null; then
    echo "Error: exiftran is not installed. Install it using:"
    echo "  sudo apt install exiftran   # Debian/Ubuntu"
    echo "  brew install exiftran       # macOS"
    exit 1
fi

# Ensure at least one argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <file_or_directory> [file_or_directory] ..."
    exit 1
fi

# Process each argument
for path in "$@"; do
    if [ -f "$path" ]; then
        # Process a single file
        echo "Processing '$path'..."
        exiftran -ai "$path"
        echo "Done."

    elif [ -d "$path" ]; then
        # Process all images in the directory
        echo "Processing directory '$path'..."
        find "$path" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -print0 | while IFS= read -r -d '' img; do
            echo "Processing '$img'..."
            exiftran -ai "$img"
            echo "Done."
        done
    else
        echo "Skipping '$path' (not a valid file or directory)"
    fi
done

echo "All images processed!"
