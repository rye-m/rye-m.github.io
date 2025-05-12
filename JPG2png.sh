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
find "$dir" -type f -iname "*.jpg" | while read -r file; do
    # Create the output filename by replacing the extension with .png
    output="${file%.*}.jpg"
    
    # echo "Converting: $file to $output"
    # ffmpeg -i "$file" -quality 50 -y "$output" > /dev/null 2>&1
    ffmpeg -i "$file" -q:v 2 -y "$output" #> /dev/null 2>&1
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "Conversion successful: $output"
        
        # Delete the original JPG file
        # rm "$file"
        # echo "Deleted original file: $file"
    else
        echo "Error converting: $file - original file kept"
    fi
done

echo "Conversion complete!"