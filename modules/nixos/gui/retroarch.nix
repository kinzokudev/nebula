{
  flake.nixosModules.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      (retroarch.withCores (cores:
        # Emulator frontend
          with cores; [
            pcsx2 # PS2
            swanstation # PS1
            pcsx-rearmed # PS1
          ]))
    ];
  };
}
