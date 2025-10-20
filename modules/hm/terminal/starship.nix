{
  config,
  lib,
  ...
}: {
  options.custom = {
    starship = {
      enable =
        lib.mkEnableOption "starship"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = config.custom.fish.enable;
    };
    xdg.configFile = {
      "starship.toml".source = ./starship.toml;
    };
  };
}
