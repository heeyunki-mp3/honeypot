#!/bin/bash

# Function to check if the required arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ssh_endpoint>"
    exit 1
fi

# Variables
SSH_ENDPOINT=$1
REMOTE_DIR="~/tpotce/data/cowrie"
LOCAL_DIR="./"
LOCAL_DEST="${LOCAL_DIR}${SSH_ENDPOINT}_cowrie"
SSH_PORT=64295

# Create a local directory with the SSH endpoint name
mkdir -p "$LOCAL_DEST"

# Using scp to recursively download the contents of the remote directory
scp -P $SSH_PORT -r "$SSH_ENDPOINT:$REMOTE_DIR/*" "$LOCAL_DEST"

# Notify user of completion
if [ $? -eq 0 ]; then
    echo "Download complete. Data saved to $LOCAL_DEST"
else
    echo "Error occurred during download"
fi
