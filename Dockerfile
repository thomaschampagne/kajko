
ARG OCI_BASE_IMAGE=fedora:43 # TODO:later Set base version as a build ARG
ARG OCI_BASE_IMAGE_URL=https://hub.docker.com/_/fedora
ARG OCI_TITLE=oci-vault-image
ARG OCI_REPO_URL=https://github.com/thomaschampagne/kajko
ARG OCI_DESCRIPTION="...TODO...." # TODO ...
ARG OCI_MAINTAINER="Thomas Champagne"
ARG SYSTEM_USERNAME="dev"
ARG DEFAULT_WORKSPACE_DIR="/workspace"

FROM ${OCI_BASE_IMAGE}

ARG OCI_BASE_IMAGE
ARG OCI_BASE_IMAGE_URL
ARG OCI_TITLE
ARG OCI_DESCRIPTION
ARG OCI_MAINTAINER
ARG OCI_REPO_URL
ARG OCI_BUILD_DATE
ARG SYSTEM_USERNAME
ARG DEFAULT_WORKSPACE_DIR
ARG GITHUB_TOKEN

ENV OCI_BASE_IMAGE=${OCI_BASE_IMAGE}
ENV OCI_BASE_IMAGE_URL=${OCI_BASE_IMAGE_URL}
ENV OCI_TITLE=${OCI_TITLE}
ENV OCI_DESCRIPTION=${OCI_DESCRIPTION}
ENV OCI_MAINTAINER=${OCI_MAINTAINER}
ENV OCI_REPO_URL=${OCI_REPO_URL}
ENV OCI_BUILD_DATE=${OCI_BUILD_DATE}

# Envs From Args build
ENV SYSTEM_USERNAME=${SYSTEM_USERNAME}
ENV DEFAULT_WORKSPACE_DIR=${DEFAULT_WORKSPACE_DIR}
ENV GITHUB_TOKEN=${GITHUB_TOKEN}

# Custom Envs
ENV GIT_NAME="Your Name"
ENV GIT_EMAIL="your@email.com"
ENV TZ="Europe/Paris"

# System enforced envs
ENV TERM="xterm-256color"
ENV COLORTERM="truecolor"

LABEL \
  maintainer=${OCI_MAINTAINER} \
  description=${OCI_DESCRIPTION} \
  url=${OCI_REPO_URL} \
  base-image=${OCI_BASE_IMAGE} \
  base-image-url=${OCI_BASE_IMAGE_URL} \
  org.opencontainers.image.title=${OCI_TITLE} \
  org.opencontainers.image.description=${OCI_DESCRIPTION} \
  org.opencontainers.image.created=${OCI_BUILD_DATE} \
  org.opencontainers.image.authors=${OCI_MAINTAINER} \
  org.opencontainers.image.url=${OCI_REPO_URL} \
  org.opencontainers.image.base.name=${OCI_BASE_IMAGE} \
  org.opencontainers.image.base.url=${OCI_BASE_IMAGE_URL}

# Switch to setup workspace for init & config
WORKDIR /setup

# TODO Remove safe integrity layer for image build cache usage at the (COPY + RUN)

###### Setup system side & config #######
COPY ./setup/system/packages.init.sh ./system/packages.init.sh
RUN bash ./system/packages.init.sh

COPY ./setup/system/os.config.sh ./system/os.config.sh
RUN bash ./system/os.config.sh

###### Setup dev tools baseline & config #######
COPY ./setup/dev-tools/base/packages.init.sh ./setup/dev-tools/base/packages.init.sh
RUN runuser -u ${SYSTEM_USERNAME} -- bash ./setup/dev-tools/base/packages.init.sh

COPY ./setup/dev-tools/base/user.config.sh ./dev-tools/base/user.config.sh
RUN runuser -u ${SYSTEM_USERNAME} -- bash ./dev-tools/base/user.config.sh

# Switch to default workspace directory
WORKDIR ${DEFAULT_WORKSPACE_DIR}

# ... and default user
USER ${SYSTEM_USERNAME}

CMD ["/bin/sh", "-c", "sleep infinity"]
