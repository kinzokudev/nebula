{inputs, ...}: {
  flake.nixosModules.chat = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.fluxer-nix.packages.${pkgs.system}.fluxer
    ];
  };
}
