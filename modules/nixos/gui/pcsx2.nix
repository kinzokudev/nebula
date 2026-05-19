{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      pcsx2 # PS2 emulator
    ];
  };
}
