{
  reload = "source $ZDOTDIR/.zshrc";

  ls = "lsd";
  la = "lsd -lah";
  ll = "lsd -l";
  cd = "z";
  cdi = "zi";
  cat = "bat";
  man = "batman";
  ping = "gping";
  dig = "doggo";
  top = "btop";

  tf = "terraform";
  lgit = "lazygit";
  ldoc = "lazydocker";
  lsql = "lazysql";
  glg = "git lg";
  gst = "git status";
  gco = "git checkout";
  ghc = "gh copilot";
  "git open" = "gh browse";

  db = "devbox";
  dbs = "devbox shell";
  dbr = "devbox run";

  # nix manual aliases

  man-nix = "man 5 configuration.nix";
  # NOTE: nix-darwin replaces this when installed
  man-nix-hm = "man 5 home-configuration.nix";
}
