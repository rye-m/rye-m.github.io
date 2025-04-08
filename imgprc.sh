#!/bin/bash

# Check if a directory was provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Store the directory path
dir="$1"

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory '$dir' does not exist"
    exit 1
fi

# Find all JPG and JPEG files (case insensitive) and convert them
find "$dir" -type f -iname "*.JPG" -o -iname "*.jpeg" | while read -r file; do
    # Create the output filename by replacing the extension with .png
    output="${file%.*}.png"
    
    echo "Converting: $file to $output"
    ffmpeg -i "$file" "$output"
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "Conversion successful: $output"
        
        # Delete the original JPG file
        rm "$file"
        echo "Deleted original file: $file"
    else
        echo "Error converting: $file - original file kept"
    fi
done

echo "Conversion complete!"