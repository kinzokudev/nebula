{
  inputs,
  config,
  self,
  ...
}: let
  inherit (inputs.nixpkgs) lib;
  userinfo = {
    name = "kinzoku";
    fullname = "Kira";
    email = "kin@kinzoku.dev";
    timezone = "America/New_York";
    handles = {
      github = "kinzokudev";
    };
  };
  mkHost = hostname: {
    isVm ? false,
    extraConfig ? {},
  }:
    lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          self
          userinfo
          hostname
          isVm
          ;
        isLaptop = hostname == "tempest";
        flakedir = "/home/${userinfo.name}/Workspace/Dev/nebula";
      };
      modules = [
        config.flake.nixosModules."host-${hostname}"

        # ./hosts/${lib.toLower hostname}
        # ./modules
        # ./overlays
        # (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" userinfo.name])
      ];
    };
in {
  "NOVA" = mkSystem "NOVA";
}
