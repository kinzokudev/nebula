{
  flake.nixosModules.gui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      gimp # GNU Image Manipulation Program
    ];
  };
}
