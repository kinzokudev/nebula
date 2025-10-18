{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options.custom = {
    steam = {
      enable = lib.mkEnableOption "Steam";
    };
  };
  imports = [
    # Import platform optimizations module from nix-gaming
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  config = lib.mkIf config.custom.steam.enable {
    programs = {
      steam = {
        # Enable Steam
        enable = true;
        remotePlay.openFirewall = true; # Open firewall ports
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true; # Enable GameScope session
        platformOptimizations.enable = true; # Enable platform optimizations from nix-gaming
        extraCompatPackages = with pkgs; [ proton-ge-bin ]; # Add ProtonGE
      };
      # Enable GameMode to optimize system performance on demand
      gamemode.enable = true;
    };

    nixpkgs = {
      config = {
        packageOverrides = pkgs: {
          # Fix for Steam
          steam = pkgs.steam.override {
            extraPkgs =
              pkgs: with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          };
        };
      };
      overlays = [
        # Fix for Steam
        (_final: prev: {
          steam = prev.steam.override (
            {
              extraLibraries ? _pkgs': [ ],
              ...
            }:
            {
              extraLibraries = pkgs': (extraLibraries pkgs') ++ [ pkgs'.gperftools ];
            }
          );
        })
      ];
    };
  };
}
