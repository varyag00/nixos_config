{
  reload = "source $ZDOTDIR/.zshrc";

  ls = "lsd";
  la = "lsd -lah";
  ll = "lsd -l";
  cd = "z";
  cdi = "zi";
  cat = "bat";
  bman = "batman";
  man = "batman";
  ping = "gping";
  dig = "doggo";
  top = "btop";

  lgit = "lazygit";
  ldoc = "lazydocker";
  lsql = "lazysql";
  ldb = "lazysql";

  glg = "git lg";
  "git lg" = "git lg";
  gst = "git status";
  "git st" = "git status";
  gco = "git checkout";
  "git co" = "git checkout";

  ghc = "gh copilot";
  "git open" = "gh browse";

  dv = "devbox";
  dvs = "devbox shell";
  dvr = "devbox run";

  # nix manual aliases
  man-nix = "man 5 configuration.nix";
  # NOTE: nix-darwin replaces this when installed
  man-nix-hm = "man 5 home-configuration.nix";
  ff = "aerospace list-windows --all | fzf --bind 'enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort'";
}
