{
  flake.nixosModules.gui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      parabolic # Graphical frontend for yt-dlp
    ];
  };
}
