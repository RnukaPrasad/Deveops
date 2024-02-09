#!/bin/bash

# Install jq if not installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install jq
    else
        sudo apt-get update
        sudo apt-get install -y jq
    fi
fi
