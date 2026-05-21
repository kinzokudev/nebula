{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      dolphin-emu # Wii/GameCube emulator
    ];
  };
}
