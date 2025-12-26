{
  inputs = {
    #|===|#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    #
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #|===|#

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-nix = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    };
    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixosConfigurations = import ./hosts.nix {
      inherit lib inputs outputs userinfo;
    };
  };
}
