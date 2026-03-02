{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    inputs.fluxer-nix.packages.${pkgs.system}.fluxer
  ];
}
