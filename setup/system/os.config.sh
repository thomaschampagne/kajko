#!/bin/bash

set -e
set -o pipefail

# Create the main user
useradd -m -d /home/${SYSTEM_USERNAME} -s /bin/bash -G wheel ${SYSTEM_USERNAME}

# Add workspace dir
mkdir -p ${DEFAULT_WORKSPACE_DIR}
chown -R ${SYSTEM_USERNAME}:${SYSTEM_USERNAME} ${DEFAULT_WORKSPACE_DIR}

# Allow to execute sudo without a password
echo "${SYSTEM_USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SYSTEM_USERNAME}
chmod 0440 /etc/sudoers.d/${SYSTEM_USERNAME}