#!/bin/bash

numberOfArgs=$#

if [ $# -eq 1 ]; then
    pod_nick=$1
elif [ $# -eq 2 ]; then
    ns=$1
    pod_nick=$2
fi

pod_index=-1  # Initialize with an invalid value
# Check if string is an integer
if [[ $pod_nick =~ ^-?[0-9]+$ ]]; then
    pod_index=$pod_nick
fi

if [ -z "$ns" ]; then
    pods=$(kubectl get pods -A -o jsonpath='{range .items[*]}{.metadata.namespace}/{.metadata.name}{"\n"}{end}')
else
    pods=$(kubectl get pods -n $ns -o jsonpath='{range .items[*]}{.metadata.namespace}/{.metadata.name}{"\n"}{end}')
fi
# Fetch all pods
IFS=$'\n'  # Set Internal Field Separator to newline for the loop
index=1
for pod_info in $pods; do
    IFS='/' read -ra ADDR <<< "$pod_info"
    pod_ns="${ADDR[0]}"
    pod_name="${ADDR[1]}"
    if [[ $index -eq $pod_index ]]; then
        echo "kubectl logs $pod_name -n $pod_ns"
        kubectl logs $pod_name -n $pod_ns | less
        break
    elif [[ $pod_name == *$pod_nick* ]]; then
        echo "kubectl logs $pod_name -n $pod_ns"
        kubectl logs $pod_name -n $pod_ns | less
        break 
    fi
    ((index++))
done
