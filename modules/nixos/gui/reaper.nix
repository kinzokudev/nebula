{
  flake.nixosModules.reaper = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      reaper # DAW
    ];
  };
}
