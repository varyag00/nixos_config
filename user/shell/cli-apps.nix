{ pkgs, ... }: {
  home.packages = with pkgs; [ zellij delta lazygit lazydocker ];
  programs.git = {
    enable = true;
    # TODO: take and use userSetting config
    userName = "Dan Gonzalez";
    userEmail = "jdgonzal@proton.me";
    extraConfig = {
      core = { editor = "nvim"; };
      color = { ui = true; };
      push = { default = "simple"; };
      pull = { ff = "only"; };
      init = { defaultBranch = "main"; };
    };
    ignores = [ ".DS_Store" "*.pyc" ".vscode/*" ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };

  };
}
