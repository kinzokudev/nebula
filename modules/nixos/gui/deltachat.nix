{
  flake.nixosModules.chat = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.deltachat-desktop
    ];
  };
}
