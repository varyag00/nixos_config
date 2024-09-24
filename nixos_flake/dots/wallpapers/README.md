# Wallpapers

Generated using [nix-wallpaper](https://github.com/lunik1/nix-wallpaper) flake.

## Info

> [!IMPORTANT]
> home-manager applies the wallpaper on activation. To disable this or change the applied wallpaper, update `home.activation.setWallpaper`.

## Usage

To re-generate, or generate a new wallpaper:

```sh
nix build --impure --expr '(builtins.getFlake "github:lunik1/nix-wallpaper").packages.${builtins.currentSystem}.default.override { preset = "catppuccin-macchiato"; }'
```

To set the wallpaper programmatically (macOS):

```sh
desktoppr "$NIX_DOTS/mac/wallpapers/nixos-catppuccin-macchiato.png"
```
