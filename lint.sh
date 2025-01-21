#!/bin/sh

linter=$(xcrun --find swift-format)

if [ -z "$linter" ]; then
    echo "error: swift-format not found" >&2
    exit 1
fi

# Define the configuration file path
SRCROOT="."
CONFIG_PATH="$SRCROOT/.swiftformat"

if [ -f "$CONFIG_PATH" ]; then
    echo "Using configuration file: $CONFIG_PATH"

    # Run the linter and capture its output
    $linter lint --configuration "$CONFIG_PATH" -r "$SRCROOT" 2>&1
else
    echo "error: Config file not found at: $CONFIG_PATH" >&2
    exit 1
fi
