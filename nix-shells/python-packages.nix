{ pkgs ? import <nixpkgs> {} }:
let
  env = pkgs.mkShell {
    buildInputs = [
      pkgs.pipx
      pkgs.python3Packages.pyarrow
    ];
    shellHook = ''
      pipx install harlequin
      pipx inject harlequin harlequin-mysql
      pipx inject harlequin harlequin-postgres

      pipx install posting
    '';

    HARLEQUIN = "$HOME/.local/bin/harlequin";
    # https://github.com/darrenburns/posting
    POSTING = "$HOME/.local/bin/posting";
  };
in
env
