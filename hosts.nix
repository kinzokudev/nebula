{
  lib,
  inputs,
  outputs,
  ...
}: let
  userinfo = {
    name = "kinzoku";
    fullname = "Kira";
    email = "kin@kinzoku.dev";
    timezone = "America/New_York";
    handles = {
      github = "kinzokudev";
    };
  };
  mkSystem = hostname:
    lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit
          inputs
          outputs
          userinfo
          hostname
          ;
        flakedir = "/home/${userinfo.name}/Workspace/Dev/nebula";
      };
      modules = [
        ./hosts/${lib.toLower hostname}
        ./modules
        ./overlays
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" userinfo.name])
      ];
    };
in {
  "NOVA" = mkSystem "NOVA";
}
