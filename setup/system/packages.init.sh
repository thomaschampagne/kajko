#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

### Assert Envs Properly set ###
: "${SYSTEM_USERNAME:?Environment variable SYSTEM_USERNAME is not set}"
: "${DEFAULT_WORKSPACE_DIR:?Environment variable DEFAULT_WORKSPACE_DIR is not set}"

### Add repos ###
dnf copr enable jdxcode/mise -y # Mise

### Apply Updates ###
echo "Apply updates"
dnf upgrade -y

### Apply core installs ###
echo "Install base packages"
dnf install -y --setopt=install_weak_deps=False \
  sudo \
  hostname \
  coreutils \
  libicu \
  util-linux \
  shadow-utils \
  gcc \
  gettext \
  dos2unix \
  less \
  tree \
  which \
  findutils \
  procps-ng \
  psmisc \
  bind-utils \
  iproute \
  iputils \
  traceroute \
  nmap \
  netcat \
  tcpdump \
  file \
  nano \
  vim \
  unzip \
  7zip \
  git-core \
  openssl \
  curl \
  wget \
  jq \
  yq \
  btop \
  htop \
  mise

# TODO support zsh later by default 

echo "Removing unnecessary packages..."
dnf autoremove -y

echo "Cleaning up..."
dnf clean all -y

# runuser -u ${SYSTEM_USERNAME} -- bash "$(dirname "$0")/user.config.sh"
