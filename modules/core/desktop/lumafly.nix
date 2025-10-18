{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    lumafly = {
      enable = lib.mkEnableOption "Lumafly";
    };
  };
  config = lib.mkIf config.custom.lumafly.enable {
    environment.systemPackages = with pkgs; [
      lumafly # Mod manager for Hollow Knight
    ];
  };
}
