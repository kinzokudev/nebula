{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rpcs3 # PS3 emulator
    ];
  };
}
