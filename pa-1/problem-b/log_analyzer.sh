#!/bin/bash

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

# Read log file and extract relevant columns
content_sizes=($(awk '{gsub(/-/, "0"); print $NF}' "$1"))
response_codes=($(awk '{print $(NF-1)}' "$1"))

# Calculate average content size and count unique response codes
total_size=0
declare -A codes
for size in "${content_sizes[@]}"; do
    total_size=$((total_size+size))
done
avg_size=$((total_size/${#content_sizes[@]}))
for code in "${response_codes[@]}"; do
    codes[$code]=1
done
num_codes=${#codes[@]}

# Print results
echo "$avg_size"
echo "$num_codes"
