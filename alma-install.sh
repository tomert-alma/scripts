#!/bin/zsh

# Function to save GitHub credentials
save_github_credentials() {
  # Check if GitHub credentials have already been added
  if grep -q "######## GitHub Credentials Start" ~/.zshrc; then
    echo "GitHub credentials have already been added to your .zshrc file."
    return 0
  fi

  # Ask the user for their credentials
  read "github_token?Please enter your GitHub token: "
  read "github_user?Please enter your GitHub username: "
  read "github_email?Please enter your GitHub email: "

  # Check if any of the inputs are empty and return if true
  if [[ -z "$github_token" || -z "$github_user" || -z "$github_email" ]]; then
    echo "One or more inputs were not provided. Exiting without changes."
    return 1
  fi
  
  # Add a header for GitHub credentials
  echo "\n######## GitHub Credentials Start ########\n" >> ~/.zshrc

  # Set the GitHub credentials
  set_env_var GITHUB_TOKEN "$github_token"
  set_env_var GITHUB_USER "$github_user"
  set_env_var GITHUB_EMAIL "$github_email"

  # Add a footer for GitHub credentials
  echo "\n######## GitHub Credentials End ########\n" >> ~/.zshrc

  echo "Your GitHub credentials have been saved."
}

# Function to safely set environment variables
set_env_var() {
  local var_name="$1"
  local var_value="$2"
  local file=~/.zshrc

  # Escape any characters that would break the .zshrc syntax
  var_value=$(printf '%s\n' "$var_value" | sed 's/[&/\]/\\&/g')

  # Append the new environment variable
  echo "export $var_name=\"$var_value\"" >> "$file"
}

create_scripts_aliases() {
  local SCRIPTS_DIR="$(pwd)"

  if ! grep -q "######## Alma Aliases Start" ~/.zshrc; then
    # Add a header for Alma aliases
    echo "\n######## Alma Aliases Start ########\n" >> ~/.zshrc
  fi

  # Iterate over each script file and create an alias
  find "$SCRIPTS_DIR" -type f -name "*.sh" | while read file; do
    local filename=$(basename -- "$file")
    local alias_name="${filename%.*}"
    create_alias "$alias_name" "$file"
  done
  
  add_klogs_aliases
  
  if ! grep -q "######## Alma Aliases End" ~/.zshrc; then
    # Add a footer for Alma aliases
    echo "\n######## Alma Aliases End ########\n" >> ~/.zshrc
  fi

  echo "Script aliases have been added to your .zshrc file."
}

# Function to create an individual alias
create_alias() {
  local alias_name="$1"
  local command="$2"

  # Check if the alias is already in the .zshrc
  if ! grep -q "alias $alias_name=" ~/.zshrc; then
    # Append the new alias to the .zshrc file
    echo "alias $alias_name='$command'" >> ~/.zshrc
    echo "Added alias $alias_name."
  else
    echo "Alias $alias_name already exists, skipping..."
  fi
}

add_klogs_aliases() {
  # Define the aliases as an associative array
  declare -A aliases
  aliases=(
    [otlpgw-logs]='/usr/local/bin/klogs gw-otlp'
    [ddgw-logs]='/usr/local/bin/klogs gw-datadog'
    [query-logs]='/usr/local/bin/klogs query-processor'
    [topic-logs]='/usr/local/bin/klogs topic-processor'
    [trace-agg-logs]='/usr/local/bin/klogs trace-aggregator'
    [trace-logs]='/usr/local/bin/klogs trace-processor'
  )

  # Add each alias
  for name in "${(@k)aliases}"; do
    create_alias $name "${aliases[$name]}"
  done
}
install() {
  cp "$ZSHRC_FILE" "${ZSHRC_FILE}.backup"

  if ! grep -q "######## Alma Scripts Start" ~/.zshrc; then
      # Add a header for Alma scripts
      echo "\n############### Alma Scripts Start ###############" >> ~/.zshrc
  fi

  # Export the SCRIPTS_DIR to PATH if it's not already present
  if ! grep -q "export PATH=\"\$PATH:$(pwd)\"" ~/.zshrc; then
      echo "export PATH=\"\$PATH:$(pwd)\"" >> ~/.zshrc
  fi
  
  # Prompt user for the absolute path of the infra repository
  read "infra_abs_path?Please enter your infra repo absolute path (for example /Users/tomertwig/Alma/infra): "
  
  # Remove any trailing slashes to avoid double slashes in paths
  infra_abs_path="${infra_abs_path%/}"

  # Check if INFRA_PATH is already set and add it if not
  if ! grep -q "export INFRA_PATH=" ~/.zshrc; then
    # Write the INFRA_PATH variable to .zshrc without backslashes or quotes
    echo "export INFRA_PATH="${infra_abs_path}"" >> ~/.zshrc
  fi


  # Call function to save GitHub credentials
  save_github_credentials
  
  # Call function to create scripts aliases
  create_scripts_aliases

  if ! grep -q "######## Alma Scripts End" ~/.zshrc; then
    # Add a footer for Alma scripts
    echo "\n############### Alma Scripts End ###############\n" >> ~/.zshrc
  fi

  echo "Please run 'source ~/.zshrc' to apply the changes."
}

# Call the install function
install
