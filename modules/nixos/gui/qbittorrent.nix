{
  flake.nixosModules.qbittorrent = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      qbittorrent # BitTorrent client
    ];
  };
}
