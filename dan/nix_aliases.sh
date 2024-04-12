alias vi="nvim"

# default rebuild
alias nix_rb="sudo nixos-rebuild switch"

# rebuild using /etc/nixos/flake.nix (default)
# requires enabling flakes in /etc/nixos/dan_conf.nix
alias nix_rbf="sudo nixos-rebuild switch --flake ."
