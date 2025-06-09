# run every every 30m on tuesday from 7-10
# 0,30 7-10 * * 2
# update an unpack nixpkgs-weekly flake early to avoid long unpacking it when I need it
# only unpacks the "checks" part
/nix/var/nix/profiles/default/bin/nix flake metadata "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/%2A.tar.gz"

# also unpacks devShells
# /nix/var/nix/profiles/default/bin/nix flake metadata "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/%2A.tar.gz"
