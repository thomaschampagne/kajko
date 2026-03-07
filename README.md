# Doc

## Build
podman build -t fedora-dev .

## Run (Interactive with TTY)
podman run -it --rm -v $(pwd):/home/dev/workspace fedora-dev

## IDEAS Todo

- Jetbrain Mono

- programs:
  - neovim
  - opencode
  - yazy => helix
  - fd, fzf, others usefull
  - lazygit

- set an hostname
- drop dev user password for sudos ok
- runtimes
  - bunjs
  - node
  - java
  - rust
  - golang
  - python

- helix languages
  - ..
  - ...

- git config:
  - dont break git ending

- doc:
  - run on networks host for ports
