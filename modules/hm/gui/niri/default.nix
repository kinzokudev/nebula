{inputs, ...}: {
  imports = [
    inputs.niri-nix.homeModules.default
    ./niri.nix
  ];
}
