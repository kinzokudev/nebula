{
  config,
  lib,
  ...
}: {
  options.custom = {
    eza = {
      enable =
        lib.mkEnableOption "eza"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.eza.enable {
    programs.eza = {
      enable = true;
      enableFishIntegration = config.custom.fish.enable;
      icons = "auto";
    };
  };
}
