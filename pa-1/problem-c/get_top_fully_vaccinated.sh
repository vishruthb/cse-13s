#!/bin/bash

# Check number of args
if [ $# -ne 2 ]; then
  echo "Invalid args"
  exit 1
fi

# Check if file exists AND is readable
if [ ! -r $1 ]; then
  echo "Cannot find/read $1"
  exit 1
fi

# Read CSV > sort by pct vaccinated and print top k rows
csp=$(tail -n +2 $1 | awk -F ',' '{ print $4 "," $5 "," $6 }' | sort -t ',' -k3rn -k1,1 | uniq | head -$2)

# Print top k rows
echo "$csp" | awk -F ',' '{ printf "%s,%s,%s\n", $1, $2, $3 }'