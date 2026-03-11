{
  flake.nixosModules.chat = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.stoat-desktop
    ];
  };
}
