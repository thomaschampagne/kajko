# Stop execution on any error (like set -e)
$ErrorActionPreference = "Stop"

# Remove existing container if it exists
podman rm -f kajko

# Build the container
$Date = Get-Date -Format "yyyy-MM-dd"
podman build `
    --build-arg OCI_BUILD_DATE=$Date `
    -t kajko:dev .

# Run the container
podman run -dit `
    --name kajko `
    --hostname kajko `
    --user dev `
    --env GIT_NAME="Thomas Champagne" `
    --env GIT_EMAIL="thomas.champagne@fakemail.com" `
    --workdir /workspace `
    --volume "${pwd}:/workspace" `
    --network=host `
    --cap-add=NET_RAW `
    kajko:dev

# Attach to the container
podman exec -it kajko bash