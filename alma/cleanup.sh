#!/usr/bin/expect -f
set timeout 400
source ~/.zshrc

# Define the timeout for each interaction
cd "$env(INFRA_PATH)/helm"

# Run your script
spawn ./cleanup.sh
expect eof
