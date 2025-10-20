{
  config,
  lib,
  ...
}: {
  options.custom = {
    docker = {
      enable = lib.mkEnableOption "Docker";
    };
  };
  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker = {
      # Enable Docker
      enable = true;
    };
  };
}
