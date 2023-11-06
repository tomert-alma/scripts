#!/bin/bash

# Path to the .zshrc file
ZSHRC_FILE="$HOME/.zshrc"

# Create a backup of the original .zshrc file before modifying
cp "$ZSHRC_FILE" "${ZSHRC_FILE}.bak"

# Use sed to remove the block of text including the start and end lines
sed '/############### Alma Scripts Start ###############/,/############### Alma Scripts End ###############/d' "${ZSHRC_FILE}.bak" > "$ZSHRC_FILE"

echo "Alma scripts section has been removed from your .zshrc file."
