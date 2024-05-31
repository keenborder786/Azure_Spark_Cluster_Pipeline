#!/bin/bash

# Ensure required environment variables are set
if [ -z "$IDENTITY_FILE" ]; then
    echo "Error: IDENTITY_FILE environment variable is not set."
    exit 1
fi

if [ -z "$REMOTE_USER" ]; then
    echo "Error: REMOTE_USER environment variable is not set."
    exit 1
fi

if [ -z "$REMOTE_HOST" ]; then
    echo "Error: REMOTE_HOST environment variable is not set."
    exit 1
fi


REMOTE_PATH="/home/$REMOTE_USER/output"
LOCAL_PATH="./src"

# Perform the SCP operation
echo "Using identity file: $IDENTITY_FILE"
echo "Connecting to: $REMOTE_USER@$REMOTE_HOST"
echo "Remote path: $REMOTE_PATH"
echo "Local path: $LOCAL_PATH"
scp -i "$IDENTITY_FILE" -rp $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH

# Check if SCP was successful
if [ $? -eq 0 ]; then
    echo "Files transferred successfully."
else
    echo "Error: File transfer failed."
fi