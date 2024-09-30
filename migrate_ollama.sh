#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required commands
for cmd in docker sudo; do
    if ! command_exists "$cmd"; then
        echo "Error: $cmd is required but not installed. Please install it and try again."
        exit 1
    fi
done

# Stop Ollama Snap service
echo "Stopping Ollama Snap service..."
sudo snap stop ollama

# Create Docker volume
echo "Creating Docker volume 'ollama'..."
docker volume create ollama

# Copy Snap data to Docker volume
echo "Copying Ollama data from Snap to Docker volume..."
sudo docker run --rm -v ollama:/data -v /var/snap/ollama/common:/backup alpine sh -c "cp -r /backup/* /data/"

# Run Ollama Docker container
echo "Starting Ollama Docker container..."
docker run -d --name ollama -v ollama:/root/.ollama -p 11434:11434 ollama/ollama

# Wait for container to start
echo "Waiting for Ollama container to start..."
sleep 5

# Verify Ollama is running
echo "Verifying Ollama installation..."
if docker exec -it ollama ollama list >/dev/null 2>&1; then
    echo "Ollama is running successfully in Docker!"
else
    echo "Error: Ollama doesn't seem to be running correctly in Docker."
    exit 1
fi

# Add alias to shell configuration
echo "Adding 'ollama' alias to shell configuration..."
echo 'alias ollama="docker exec -it ollama ollama"' >> ~/.bashrc
echo "Alias added. Please run 'source ~/.bashrc' to apply changes."

# Prompt user to remove Snap installation
read -p "Do you want to remove the Ollama Snap installation? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Removing Ollama Snap installation..."
    sudo snap remove ollama
else
    echo "Keeping Ollama Snap installation."
fi

echo "Migration complete!"
