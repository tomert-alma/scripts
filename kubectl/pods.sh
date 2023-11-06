#!/bin/bash
ns=$1
# Check if namespace (ns) is provided
if [ -z "$ns" ]; then
    output=$(kubectl get pods -A)
else
    echo "kubectl get pods -n $ns"
    output=$(kubectl get pods -n $ns)
fi

# Print each line without leading spaces
IFS=$'\n'  # Set Internal Field Separator to newline for the loop
for line in $output; do
    printf "%s\n" "$line"
done
