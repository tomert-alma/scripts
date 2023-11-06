#!/bin/bash
ns=$1
# Check if namespace (ns) is provided
if [ -z "$ns" ]; then
    output=$(kubectl get pods -A)
else
    echo "kubectl get pods -n $ns"
    output=$(kubectl get pods -n $ns)
fi

# Print each line with an index only if "Name" is a substring of the line
index=1
IFS=$'\n'  # Set Internal Field Separator to newline for the loop
for line in $output; do
    if [[ $line == *"NAME"* ]]; then
        printf "%-3s %s\n" "" "$line" 
    else
        printf "%-3d %s\n" $index "$line"
        ((index++))
    fi

done
