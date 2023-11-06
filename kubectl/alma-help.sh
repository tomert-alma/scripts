#!/bin/zsh

# Source your .zshrc to make aliases available
source ~/.zshrc


# Print the header
echo "Scripts               Description"
echo "-----------------------------------"


# Define an associative array with descriptions for each alias
typeset -A alias_descriptions
alias_descriptions=(
  install "install infra helm local env"
  installing "install infra helm local env"
  upgrade "upgrade infra helm local env"
  cleanup "cleanup infra helm local env"
  alma-help "how to use alma scripts"
  pods "all running pods in your kubectl"
  deploy "all running deployments in your kubectl"
  ddgw-logs "logs for datadog gateway"
  otlpgw-logs "logs for otlp gateway"
  query-logs "logs for query-processor"
  topic-logs "logs for topic-processor"
  trace-logs "logs for trace-processor"
  trace-agg-logs "logs for trace-aggregator"
)

# Print the alias names and their descriptions in a formatted manner
awk '/# Alma Aliases Start/,/# Alma Aliases End/' ~/.zshrc | grep '^alias' | awk -F'=' '{print $1}' | sed 's/alias //' | while read -r alias_name; do
  # Exclude specified aliases

  if [[ "$alias_name" != "pod_logs" && "$alias_name" != "alma-help" && "$alias_name" != "alma-uninstall" && "$alias_name" != "alma-install" ]]; then
    # Print alias and description
    printf "%-20s %s\n" "$alias_name" "${alias_descriptions[$alias_name]}"
  fi
done
