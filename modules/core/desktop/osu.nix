{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    osu = {
      enable = lib.mkEnableOption "Osu";
    };
  };
  config = lib.mkIf config.custom.osu.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin # Osu
    ];
  };
}
