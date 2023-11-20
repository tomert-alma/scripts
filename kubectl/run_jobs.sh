#!/bin/bash

# Define the job name and namespace if necessary
job_name="integration-tests-job"
namespace="alma"

# Function to check the status of the last job
check_job_status() {
    # Fetch the number of successful completions
    local success_count=$(kubectl get jobs integration-tests-job -n alma -o=jsonpath='{.status.succeeded}')
    
    # Check if the job has succeeded
    if [ "$success_count" -gt 0 ]; then
        echo "Job $job_name succeeded"
        return 1
    else
        echo "Job $job_name did not succeed"
        return 0
    fi
}


# Run the job 100 times
for i in {1..100}; do
    echo "Running job iteration $i"
    kubectl delete -f docker/integration-tests.yaml && kubectl apply -f docker/integration-tests.yaml

    # Wait for the job to complete
    kubectl wait --for=condition=complete job/integration-tests-job -n alma --timeout=3m

    # Check if the job failed
    check_job_status
    if [ $? -ne 1 ]; then
        echo "Stopping due to job failure."
        exit 1
    fi
done

echo "All jobs completed successfully"
