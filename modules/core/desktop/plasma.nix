{
  config,
  lib,
  ...
}:
{
  options.custom = {
    plasma = {
      enable = lib.mkEnableOption "Plasma" // {
        default = true;
      };
    };
  };
  config = lib.mkIf config.custom.plasma.enable {
    services.desktopManager.plasma6 = {
      # Enable KDE Plasma desktop environment
      enable = true;
    };
  };
}
