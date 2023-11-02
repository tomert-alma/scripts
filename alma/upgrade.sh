#!/usr/bin/expect -f
set timeout 240

cd /Users/tomertwig/Alma/infra/helm

# Run your script
spawn ./upgrade.sh

# Wait for the script to finish
expect eof
