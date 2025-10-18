{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    qbittorrent = {
      enable = lib.mkEnableOption "qBittorrent";
    };
  };
  config = lib.mkIf config.custom.qbittorrent.enable {
    environment.systemPackages = with pkgs; [
      qbittorrent # BitTorrent client
    ];
  };
}
