{
  flake.nixosModules.gui = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.audacity
    ];
  };
}
