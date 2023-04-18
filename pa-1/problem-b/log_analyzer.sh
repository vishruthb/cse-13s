#!/bin/bash

# Compute average content size and number of unique response codes > awk best option
awk '{gsub(/-/, "0"); sum += $NF; codes[$(NF-1)] = 1} END {print sum/NR; print length(codes)}' "$1"