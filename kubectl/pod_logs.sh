#!/bin/bash

timestampsFlag=false  # Initialize the timestamps flag
pod_nick=""           # Initialize pod_nick variable

# Parse command line arguments
while [ $# -gt 0 ]; do
  case $1 in
    -t)
      timestampsFlag=true
      shift # Remove -t from processing
      ;;
    -name=*)
      pod_nick="${1#*=}"  # Extract the value right of '='
      shift # Remove -name=value from processing
      ;;
    *)
      echo "Invalid argument: $1"
      exit 1
      ;;
  esac
done

pod_index=-1  # Initialize with an invalid value
# Check if string is an integer
if [[ $pod_nick =~ ^-?[0-9]+$ ]]; then
    pod_index=$pod_nick
fi

# Fetch pods from all namespaces
pods=$(kubectl get pods -A -o jsonpath='{range .items[*]}{.metadata.namespace}/{.metadata.name}{"\n"}{end}')

# Fetch all pods
IFS=$'\n'  # Set Internal Field Separator to newline for the loop
index=1
for pod_info in $pods; do
    IFS='/' read -ra ADDR <<< "$pod_info"
    pod_ns="${ADDR[0]}"
    pod_name="${ADDR[1]}"
    if [[ $index -eq $pod_index ]]; then
        logCmd="kubectl logs $pod_name -n $pod_ns"
    elif [[ $pod_name == *$pod_nick* ]]; then
        logCmd="kubectl logs $pod_name -n $pod_ns"
    else
        ((index++))
        continue
    fi

    # Add --timestamps if flag is set
    if [ "$timestampsFlag" = true ]; then
        logCmd+=" --timestamps"
    fi

    echo $logCmd
    eval $logCmd | less
    break
done
