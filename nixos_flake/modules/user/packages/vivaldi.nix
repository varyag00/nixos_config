{ pkgs, ... }:

{
  # Module installing vivaldi as default browser
  home.packages = [ pkgs.vivaldi ];

  xdg.mimeApps.defaultApplications = {
  "text/html" = "vivaldi-stable.desktop";
  "x-scheme-handler/http" = "vivaldi-stable.desktop";
  "x-scheme-handler/https" = "vivaldi-stable.desktop";
  "x-scheme-handler/about" = "vivaldi-stable.desktop";
  "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.brave}/bin/vivaldi";
  };

}
