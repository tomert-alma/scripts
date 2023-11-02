#!/bin/bash
ns=$1

# Check if namespace (ns) is provided
if [ -z "$ns" ]; then
    echo "kubectl get deployments -A"
    kubectl get deployments -A
else
    echo "kubectl get deployments -n $ns"
    kubectl get deployments  -n $ns
fi
