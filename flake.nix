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
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    import-tree.url = "github:vic/import-tree";
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

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fluxer-nix.url = "github:ardishko/fluxer-nix";
  };

  outputs = inputs @ {flake-parts, ...}: let
  in
    flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules)
    // {
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];
    };
  # let
  #     inherit (self) outputs;
  #     lib = nixpkgs.lib // home-manager.lib;
  #   in {
  #     inherit lib;
  #     nixosConfigurations = import ./hosts.nix {
  #       inherit lib inputs outputs;
  #     };
  #   }
}
