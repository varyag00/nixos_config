# NixOS Configuration

_My personal [flake](https://nixos.wiki/wiki/Flakes)-based NixOS configuration, as well as some docs and illustrative examples._

## Structure

- [nixos_flake/](./README.md): my current nixos configuration and dotfiles flake.
- [examples/](./examples/README.md): contains some helpful examples to help illustrate the nix the different components being used here.
- [docs/](./docs/README.md): contains some personal docs for using this repo.

## Info

### Usage

Ensure that this repo is cloned into `$HOME`.

Open [.envrc](./envrc) and ensure the proper options are set. `$nixos_profile` must be set to one of the available [profiles](./nixos_flake/profiles/) for `task` to run.

Use the [taskfile](https://taskfile.dev) targets to get started. Note that on first run, `task` will not be installed so use `nix-shell -p go-task` to temporarily install it.

```sh
task install
```

Afterwards, use `task rebuild` to reload configuration.

### Why NixOS?

1. **Stability**: NixOS never breaks in day-to-day operation, and when it _does_ break while applying system changes, by design [_you always have an easily-recoverable backup_](https://nixos.wiki/wiki/Nixos-rebuild).
1. **Reproducibility**: NixOS supports specifying your entire system in fully declarative and reproducible [flakes](https://nixos.wiki/wiki/Flakes). It's a lockfile for your entire system.
1. **Features**: NixOS is extremely feature-rich, and has the largest package index for both stable and fresh packages, [nixpkgs](https://search.nixos.org/packages).

### Why not NixOS?

1. **Documentation**: Docs vary greatly in quality, freshness, and availability; it's also hard to know _where_ to look for documentation for a specific topic.
1. **Error messages**: By default, NixOS has awful error messages. This problem can be remedied using tools like [nh (nix-helper)](https://github.com/viperML/nh).
1. **The elephant in the room, [Nix language](https://nixos.org/manual/nix/stable/language/index.html)**: The Nix DSL is very well suited to its intended purpose of creating NixOS derivations. However, the fact that Nix lang is a declarative, functional, domain-specific language with a difficult learning curve is a big turn-off for some people. This is not helped by the fact that there are many different patterns to accomplish the same end goal, with vastly different tradeoffs that are not immediately clear, and with little standardization by the community, and the situation becomes confusing.

- e.g. **user package management**: `environment.systemPackages` in `configuration.nix` vs. `home-manager` vs `configuration.nix` AND `home-manager` vs `nix-env` vs ...
