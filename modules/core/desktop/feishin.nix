{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    feishin = {
      enable = lib.mkEnableOption "Feishin";
    };
  };
  config = lib.mkIf config.custom.feishin.enable {
    environment.systemPackages = with pkgs; [
      feishin # Subsonic/Jellyfin compatible music player
    ];
  };
}
