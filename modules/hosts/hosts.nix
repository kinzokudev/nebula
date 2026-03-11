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
    system ? "x86_64-linux",
    isVm ? false,
    extraConfig ? {},
  }:
    lib.nixosSystem {
      inherit system;

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
        config.flake.nixosModules.core
        (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" userinfo.name])

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit
                inputs
                userinfo
                hostname
                ;
            };

            users = {
              ${userinfo.name} = {
                imports = [
                  inputs.niri-nix.homeModules.default
                  inputs.dms.homeModules.dank-material-shell
                  inputs.nixcord.homeModules.nixcord
                ];

                home = {
                  username = "${userinfo.name}";
                  homeDirectory = "/home/${userinfo.name}";
                  stateVersion = "24.11";
                };
                programs.home-manager.enable = true; # Let Home Manager install and manage itself.
              };
            };
            backupFileExtension = "backup";
          };
        }

        ../../overlays
      ];
    };
in {
  flake.nixosConfigurations = {
    "nova" = mkHost "nova" {};
  };
}
