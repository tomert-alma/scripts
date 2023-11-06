#!/bin/zsh

# Source your .zshrc to make aliases available
source ~/.zshrc

# Create a temporary file
temp_file=$(mktemp)

# Fetch all aliases related to 'klogs' and store the output in the temporary file
alias | grep 'klogs' > "$temp_file"

# Check if the temporary file is empty, if so, exit the script
if ! [[ -s "$temp_file" ]]; then
  echo "No klogs-related aliases found."
  rm -f "$temp_file"
  exit 1
fi

# Print the header
echo "Alias         Service"
echo "------        ------------"

# Define a function to map aliases to descriptions
describe_alias() {
  case "$1" in
    ddga) echo 'datadog GA' ;;
    otlpga) echo 'OTLP GA' ;;
    query) echo 'query-processor' ;;
    topic) echo 'topic-processor' ;;
    trace) echo 'trace-processor' ;;
    trace_agg) echo 'trace-aggregator' ;;
    *) echo "Unknown" ;;  # Default description for unrecognized aliases
  esac
}

# Read each alias from the temporary file
while IFS='=' read -r name rest; do
  # Extract the alias name (removing 'alias ' prefix)
  alias_name=${name#alias }
  # Get the description for the alias
  description=$(describe_alias "$alias_name")
  # Print the alias and its description
  printf "%-12s %s\n" "$alias_name" "$description"
done < "$temp_file"

# Clean up the temporary file
rm -f "$temp_file"
