{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;

    userinfo = {
      name = "kinzoku";
      fullname = "Kira Rene";
      email = "kin@kinzoku.dev";
      timezone = "America/New_York";
      handles = {
        github = "kinzokudev";
      };
    };
  in {
    inherit lib;
    nixosConfigurations = let
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
          };
          modules = [
            ./hosts/${lib.toLower hostname}
            ./modules
            (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" userinfo.name])
          ];
        };
    in {
      "NOVA" = mkSystem "NOVA";
    };
  };
}
