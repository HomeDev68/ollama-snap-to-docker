# Ollama Snap to Docker Migration

This repository contains a script to automate the migration of Ollama from an existing Snap installation to a Docker container. It simplifies the process of containerizing your existing Ollama setup while preserving your existing models and data.

## Prerequisites

- Docker
- sudo privileges
- Ollama installed via Snap

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/HomeDev68/ollama-snap-to-docker.git
   cd ollama-snap-to-docker
   ```

2. Make the script executable:
   ```
   chmod +x migrate_ollama.sh
   ```

3. Run the migration script:
   ```
   ./migrate_ollama.sh
   ```

4. Follow the prompts in the script.

5. After the script completes, run the following command to apply the new alias:
   ```
   source ~/.bashrc
   # OR
   source ~/.zshrc # if using zsh
   ```

## What the Script Does

1. Stops the Ollama Snap service
2. Creates a Docker volume for Ollama data
3. Copies data from the Snap installation to the Docker volume
4. Starts an Ollama Docker container
5. Verifies the Ollama installation in Docker
6. Adds an alias for easy use of Ollama in Docker (`requires the removal of the Ollama Snap installation`)
7. Optionally removes the Snap installation
   
## Post-Migration Usage

After migration, you can use Ollama as before, but it will now run in a Docker container. The script adds an alias to your shell configuration, so you can use Ollama commands as usual:

```
ollama list
ollama run llama2
```

## Troubleshooting

If you encounter any issues during or after migration, please check the following:

1. Ensure Docker is running and you have necessary permissions.
2. Verify that the Ollama container is running: `docker ps`
3. Check Ollama container logs: `docker logs ollama`

If problems persist, please open an issue in this repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
