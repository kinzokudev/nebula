{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qbittorrent # BitTorrent client
  ];
}
