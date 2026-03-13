# Stop execution on any error (like set -e)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

# Remove existing container if it exists
podman rm -f enklum

# Build the container
$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
podman build `
  --build-arg OCI_BUILD_DATE=$Date `
  --build-arg-file argfile.sample.conf `
  -t enklum:dev .

# Run the container
podman run -dit `
  --name enklum `
  --hostname enklum `
  --env-file .env.sample `
  --workdir /workspace `
  --volume "${pwd}:/workspace:delegated" `
  --network=host `
  --cap-add=NET_RAW `
  enklum:dev

# Attach to the container
## Only zsh # TODO Doc it
# podman exec -it enklum zsh
## OR Directly zellij # TODO Doc it
podman exec -it enklum zsh -ic "zellij"


