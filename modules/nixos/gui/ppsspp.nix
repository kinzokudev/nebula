{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ppsspp # PSP emulator
    ];
  };
}
