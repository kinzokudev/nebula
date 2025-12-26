{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Import platform optimizations module from nix-gaming
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  programs = {
    steam = {
      # Enable and configure Steam
      enable = true;
      # Open firewall ports
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      # Enable GameScope session
      gamescopeSession.enable = true;
      # Enable platform optimizations from nix-gaming
      platformOptimizations.enable = true;

      # Extra compatibility tools
      extraCompatPackages = with pkgs; [
        proton-ge-bin # Proton GE
      ];
    };
    gamemode = {
      # Enable GameMode to optimize system performance on demand
      enable = true;
    };
    gamescope = {
      # Enable and configure Gamescope
      enable = true;
      capSysNice = true;
    };
  };

  # Enable xone driver for Xbox One/Series accessories
  hardware.xone.enable = true;

  # code monster that i stole from a friend a long time ago
  # i previously used it to fix an issue i was having with steam at the time, but i forgot what the issue was, and im too scared to remove it lol
  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        # Fix for Steam
        steam = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
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
          {extraLibraries ? _pkgs': [], ...}: {
            extraLibraries = pkgs': (extraLibraries pkgs') ++ [pkgs'.gperftools];
          }
        );
      })
    ];
  };
}
