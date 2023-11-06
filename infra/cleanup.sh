#!/usr/bin/expect -f
set timeout 400

# Define the timeout for each interaction
cd "$env(INFRA_PATH)/helm"

# Run your script
spawn ./cleanup.sh
expect eof
