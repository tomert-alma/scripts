#!/usr/bin/expect -f
set timeout 240

cd "$env(INFRA_PATH)/helm"

# Run your script
spawn ./upgrade.sh

# Wait for the script to finish
expect eof
