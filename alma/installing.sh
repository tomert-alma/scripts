#!/usr/bin/expect -f

# Define the timeout for each interaction
set timeout 10
cd /Users/tomertwig/Alma/infra/helm

# Run your script
spawn ./installing.sh

# Wait for a specific output (like a prompt) and respond
expect "Enter GitHub Token" { send "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\r" }
expect "Enter GitHub User" { send "tomert-alma\r" }
expect "Enter EMAIL" { send "tomert@alma.security\r" }

# Wait for the script to finish
expect eof
