{
  flake.nixosModules.chat = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.element-desktop
    ];
  };
}
