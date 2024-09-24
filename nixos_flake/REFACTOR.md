# Refactor

## Important & Urgent

- [x] migrate nvim config to this flake
  - [x] commit
  - [x] test
  - [x] migrate language configs
- [x] migrate zsh to this flake
  - [x] commit
  - [x] test
  - [x] fix line endings (see .zsh.bak)
- [x] migrate zellij to this flake
  - [x] commit
  - [x] test
  - [x] add back extras
- [x] migrate shell/ to this flake
  - [x] commit
  - [x] test

## Non-important & Non-urgent

- [ ] use `envVars.isWSL` flag to enable below tasks
- [ ] migrate qutebrowser to this flake
  - must allow targeting a dir (for windows: `/mnt/c/...`)
- [ ] migrate wezterm to this flake
  - must allow targeting a dir (for windows: `/mnt/c/...`)
- [ ] migrate neovide to this flake
  - must allow targeting a dir (for windows: `/mnt/c/...`)

## Important & Non-urgent

- [/] create a macos profile and macos hm modules
- [/] migrate macos-specific system modules
- [ ] use [charm/melt](https://github.com/charmbracelet/melt) for ssh-key restore
- [x] use sops-nix for this flake's secrets management
- [ ] add enVars entries for MODULES=nixos_flake/modules
  - [ ] rename `modules/system/` to `nixos`
  - [ ] rename `modules/user/` to `hm`
  - [ ] rename `modules/macos/` to `darwin`
- [ ] `.envrc` and `Taskfile` updates
  - [ ] `.envrc`: edit `FLAKE` to point to the actual flake
  - [ ] `Taskfile`: remove most of (?) `FLAKE` env
