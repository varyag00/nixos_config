{
  reload = "source $ZDOTDIR/.zshrc";

  ls = "lsd";
  la = "lsd -lah";
  ll = "lsd -l";
  cd = "z";
  cdi = "zi";
  cat = "bat";
  ping = "gping";
  dig = "doggo";

  tf = "terraform";
  lgit = "lazygit";
  ldoc = "lazydocker";
  lsql = "lazysql";
  glg = "git lg";
  gst = "git status";
  gco = "git checkout";

  db = "devbox";
  dbs = "devbox shell";
  dbr = "devbox run";

  # nix manual aliases

  man-nix = "man 5 configuration.nix";
  # NOTE: nix-darwin replaces this when installed
  man-nix-hm = "man 5 home-configuration.nix";
}
