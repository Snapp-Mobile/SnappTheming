#!/bin/bash

# Locate swift-format
linter=$(xcrun --find swift-format)

if [ -z "$linter" ]; then
    echo "error: swift-format not found" >&2
    exit 1
fi

# Resolve paths
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PACKAGE_DIRECTORY=$(cd "$SCRIPT_DIR/../.." && pwd)
CONFIG_PATH="$PACKAGE_DIRECTORY/.swiftformat"

# Debugging outputs
echo "SCRIPT_DIR: $SCRIPT_DIR"
echo "PACKAGE_DIRECTORY: $PACKAGE_DIRECTORY"
echo "CONFIG_PATH: $CONFIG_PATH"

# Check if the configuration file exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo "error: Config file not found at: $CONFIG_PATH" >&2
    exit 1
fi

# Verify the package directory exists
if [ ! -d "$PACKAGE_DIRECTORY" ]; then
    echo "error: Directory $PACKAGE_DIRECTORY does not exist" >&2
    exit 1
fi

# Run swift-format lint
echo "Linting directory: $PACKAGE_DIRECTORY"
output=$("$linter" lint --configuration "$CONFIG_PATH" -r "$PACKAGE_DIRECTORY" 2>&1)

# Debugging output
echo "Swift-format output:"
echo "$output"

# Parse and format the output for Xcode compatibility
echo "$output" | while IFS= read -r line; do
    # Match lines in the form: [file]:[line]:[column]: [level]: [message]
    if [[ $line =~ ^([^:]+):([0-9]+):([0-9]+):\ (warning|error|note):\ (.+)$ ]]; then
        file="${BASH_REMATCH[1]}"
        line_number="${BASH_REMATCH[2]}"
        column_number="${BASH_REMATCH[3]}"
        level="${BASH_REMATCH[4]}"
        message="${BASH_REMATCH[5]}"

        # Print the formatted output
        echo "$file:$line_number:$column_number: $level: $message"
    else
        # Print unmatched lines as-is for debugging
        echo "No match for line: $line" >&2
    fi
done
