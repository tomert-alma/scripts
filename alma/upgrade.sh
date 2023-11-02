#!/usr/bin/expect -f

cd /Users/tomertwig/Alma/infra/helm

# Run your script
spawn ./upgrade.sh

# Wait for the script to finish
expect eof
