# NOTE: usage
# nix-shell: 
#   - without directly: nix develop (with shell.nix in PWD)
#   - with flake: nix-shell $FLAKE#python
# direnv:
#   - in .envrc: add "use nix" OR simply install nix-direnv
{
  pkgs ? import <nixpkgs> { },
  ...
}:

pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.requests
      python-pkgs.flask
    ]))
  ];

  # TODO: poetry 

  # note sure when this is used
  # nativeBuildInputs = with pkgs; [ python ];

  shellHook = # sh
    ''
      echo "welcome"
      # source ./something.sh
      # echo "to my shell!" | {$pkgs.lolcat}/bin/lolcat 
    '';

  # COLOR = "blue";
  # PASSWORD = import ./password.nix;
}
