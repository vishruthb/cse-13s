#!/bin/bash

# Get input arguments
f=$1
k=$2

# Read stopwords file and store in array
s=($(cat stopwords | tr '\n' ' '))

# Read input file and store all read words in array
a=($(cat $f))

# Extract ONLY words from the input file to an array
w=($(grep -o -w -i '[[:alpha:]]*' $f))

# Convert all extracted words to lowercase
w=($(echo "${w[@]}" | tr '[:upper:]' '[:lower:]'))

# Remove stopwords
for stopword in ${s[@]}; do
    w=($(echo "${w[@]}" | tr ' ' '\n' | grep -vw $stopword | tr '\n' ' '))
done

# Create array to store word frequencies
declare -A f
for i in "${w[@]}"; do
    f[$i]=$((f[$i]+1))
done

# Sort words by frequency and alphabetically
sw=($(for i in "${!f[@]}"; do echo "$i ${f[$i]}"; done | sort -k2,2nr -k1,1 | head -n "$k" | awk '{print $1}'))

# Print to console
for i in "${sw[@]}"; do
    echo "$i"
done