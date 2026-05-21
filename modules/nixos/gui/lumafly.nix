{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      lumafly # Hollow Knight mod manager
    ];
  };
}
