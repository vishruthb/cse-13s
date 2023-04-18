#!/bin/bash

# Read log file and extract content sizes and response codes
cs=($(awk '{gsub(/-/, "0"); print $NF}' "$1"))
rc=($(awk '{print $(NF-1)}' "$1"))

# Calculate averages and counts
ts=0
declare -A c
for s in "${cs[@]}"; do
    ts=$((ts+s))
done
as=$((ts/${#cs[@]}))
for cd in "${rc[@]}"; do
    c[$cd]=1
done
nc=${#c[@]}

# Output results
echo "$as"
echo "$nc"
