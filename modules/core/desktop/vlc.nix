{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    vlc = {
      enable = lib.mkEnableOption "VLC";
    };
  };
  config = lib.mkIf config.custom.vlc.enable {
    environment.systemPackages = with pkgs; [
      vlc # Media player
    ];
  };
}
