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
    nix-colors.url = "github:misterio77/nix-colors";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
    polly-mc = {
      url = "github:fn2006/PollyMC";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minegrub-theme = {
      url = "github:Lxtharia/minegrub-theme";
    };
    catpuccin-cursors = {
      url = "github:catppuccin/cursors";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    };

    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprsome = {
      url = "github:sopa0/hyprsome";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyprland.url = "github:hyprland-community/pyprland";
    shadower = {
      url = "github:n3oney/shadower";
    };
    wayfreeze = {
      url = "github:jappie3/wayfreeze";
    };
    watershot = {
      url = "github:Kirottu/watershot";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }:
    let
      inherit (self) outputs;
      libPre = nixpkgs.lib // home-manager.lib;
      lib = import ./lib { inherit libPre inputs; };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      userinfo = {
        name = "kinzoku";
        fullname = "Kira Rene";
        email = "kin@kinzoku.dev";
        timezone = "America/New_York";
        handles = {
          github = "kinzokudev";
        };
      };

      treefmtEval = forEachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      inherit lib;
      devShells = forEachSystem (pkgs: {
        default = import ./shell.nix {
          inherit inputs pkgs;
        };
        # default = pkgs.mkShell {
        #   packages = with pkgs; [
        #     age
        #     sops
        #     cachix
        #     deadnix
        #     statix
        #     nixd
        #     nixfmt
        #     mdformat
        #     shfmt
        #     treefmt2
        #     wlr-randr
        #   ];
        # };
      });

      formatter = forEachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      checks = forEachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      nixosConfigurations = {
        "NOVA" = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              inputs
              outputs
              userinfo
              ;
            hostname = "NOVA";
          };
          modules = [
            inputs.nix-flatpak.nixosModules.nix-flatpak
            ./nova
            # (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" userinfo.name ])
          ];
        };
      };
    };
}
