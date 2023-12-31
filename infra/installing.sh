#!/usr/bin/expect -f
set timeout 240
# Define the timeout for each interaction
cd "$env(INFRA_PATH)/helm"

# Run your script
spawn ./installing.sh

# Wait for a specific output (like a prompt) and respond
expect "Enter GitHub Token" { send "$env(GITHUB_TOKEN)\r" }
expect "Enter GitHub User" { send "$env(GITHUB_USER)\r" }
expect "Enter EMAIL" { send "$env(GITHUB_EMAIL)\r" }

# Wait for the script to finish
expect eof
