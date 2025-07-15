# run every every 20m on tuesday from 7-12
# 0,20,40 7-12 * * 2

# update an unpack nixpkgs-weekly flake early to avoid long unpacking when I need it
# only unpacks the "checks" part
time (/nix/var/nix/profiles/default/bin/nix flake metadata "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/%2A.tar.gz")
