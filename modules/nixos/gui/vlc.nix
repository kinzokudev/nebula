{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vlc # Media player
  ];
}
