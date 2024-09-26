{
  config,
  inputs,
  pkgs-unstable,
  ...
}:
{
  imports = [ ./docker.nix ];

  # nixpkgs.config.cudaSupport = true;
  # # virtualisation.docker.enableNvidia = true;
  virtualisation.containers.cdi.dynamic.nvidia.enable = true;
  # virtualisation.docker.extraOptions = "--add-runtime nvidia=/run/current-system/sw/bin/nvidia-container-runtime";

  environment.systemPackages = [
    pkgs-unstable.ollama-cuda
    pkgs-unstable.nvidia-container-toolkit
    # pkgs-unstable.open-webui
  ];

  # services.ollama = {
  #   enable = true;
  #   package = pkgs-unstable.ollama-cuda;
  #   # NOTE: automatically set to "cuda" if nixpkgs.config.cudaSupport = true;
  #   # acceleration = "cuda";
  #   environmentVariables = {
  #     OLLAMA_HOST="0.0.0.0";
  #     OLLAMA_ORIGINS="chrome-extension://*";
  #   };
  # };

  # TODO: run open-web-ui from here as well
}
