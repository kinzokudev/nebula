{
  host ? "NOVA",
  ...
}:
let
  user = "kinzoku";
  flake = builtins.getFlake (toString ./.);
  inherit (flake) lib;
in
rec {
  inherit lib;
  inherit (flake) inputs self;
  inherit flake host user;

  inherit (flake.nixosConfigurations.${host}) pkgs;
  c = flake.nixosConfigurations.${host}.config;
  config = c;
  inherit (c) hm;
}
