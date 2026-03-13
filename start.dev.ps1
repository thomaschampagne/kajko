# Stop execution on any error (like set -e)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

# Remove existing container if it exists
podman rm -f enklum

# Build the container
$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
podman build `
  --build-arg OCI_BUILD_DATE=$Date `
  --build-arg-file argfile.conf `
  -t enklum:dev .

# Run the container
podman run -dit `
  --name enklum `
  --hostname enklum `
  --env GIT_NAME="Thomas Champagne" `
  --env GIT_EMAIL="thomas.champagne@fakemail.com" `
  --workdir /workspace `
  --volume "${pwd}:/workspace" `
  --network=host `
  --cap-add=NET_RAW `
  enklum:dev

# TODO Test delegated volume fro /home/dev. Switch to conmpose

# Attach to the container
podman exec -it enklum zsh
