{
  flake.nixosModules.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      hyfetch # fetch but WOKE
      fastfetch
    ];
  };
}
