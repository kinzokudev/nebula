{
  lib,
  inputs,
  outputs,
  ...
}: let
  userinfo = {
    name = "kinzoku";
    fullname = "Kira Rene";
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
        flakedir = "/home/${userinfo.name}/Workspace/Dev/nebula-copy";
      };
      modules = [
        ./hosts/${lib.toLower hostname}
        ./modules
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" userinfo.name])
      ];
    };
in {
  "NOVA" = mkSystem "NOVA";
}
