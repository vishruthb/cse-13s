#!/bin/bash

# Get the input arguments
filename=$1
k=$2

stopwords=($(cat stopwords | tr '\n' ' '))

words=($(cat $filename))

words=($(grep -o -w -i '[[:alpha:]]*' $filename))

words=($(echo "${words[@]}" | tr '[:upper:]' '[:lower:]'))

for stopword in ${stopwords[@]}; do
    words=($(echo "${words[@]}" | tr ' ' '\n' | grep -vw $stopword | tr '\n' ' '))
done

declare -A freq
for word in "${words[@]}"; do
    freq[$word]=$((freq[$word]+1))
done

# Sort the words by frequency, then alphabetically if frequencies are equal
sorted=($(for word in "${!freq[@]}"; do echo "$word ${freq[$word]}"; done | sort -k2,2nr -k1,1 | head -n "$k" | awk '{print $1}'))

# Print the top k most frequent words
for word in "${sorted[@]}"; do
    echo "$word"
done
