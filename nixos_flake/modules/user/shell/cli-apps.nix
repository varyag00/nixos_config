{ pkgs, pkgs-unstable, ... }:
{
  home.packages = (with pkgs; [
    lazygit
    lazydocker
    thefuck
    nap
    hurl
    go-task
    tre-command
  ]) ++ (with pkgs-unstable; [
    lazysql
  ]);
  programs.git = {
    enable = true;
    # TODO: take and use userSetting config
    userName = "Dan Gonzalez";
    userEmail = "jdgonzal@proton.me";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
    };
    aliases = {
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      co = "checkout";
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
      ".vscode/*"
    ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "base16";
        dark = true;
      };
    };
  };
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "catppuccin-macchiato";
    };
  };
}
