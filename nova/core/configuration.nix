# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  userinfo,
  inputs,
  ...
}:

{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
    # inputs.niri.nixosModules.niri
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "fs.file-max" = 1000000;
  };

  networking = {
    hostName = "NOVA";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  time.timeZone = "America/New_York";
  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  hardware.bluetooth.enable = true;
  services = {
    blueman.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us,us";
        variant = ",intl";
      };
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraLv2Packages = with pkgs; [
        lsp-plugins
        rnnoise-plugin
      ];
    };
    # jack = {
    #   alsa.enable = true;
    #   alsa.support32Bit = true;
    #   jackd.enable = true;
    # };
    openssh = {
      enable = true;
      allowSFTP = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    mullvad-vpn.enable = true;

    ollama = {
      enable = true;
      loadModels = [
        "llama3.2:3b"
        "deepseek-r1:1.5b"
      ];
      acceleration = "rocm";
    };

    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(symbols, esc)";
            };
            symbols = {
              "1" = "kp1";
              "2" = "kp2";
              "3" = "kp3";
              "4" = "kp4";
              "5" = "kp5";
              "6" = "kp6";
              "7" = "kp7";
              "8" = "kp8";
              "9" = "kp9";
              "k" = "pageup";
              "j" = "pagedown";
              "d" = "delete";
            };
          };
        };
      };
    };

    flatpak = {
      enable = true;
      packages = [
        "org.vinegarhq.Sober"
      ];
    };
  };

  # Enable sound.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      opencl = {
        enable = true;
      };
      initrd = {
        enable = true;
      };
    };
  };
  # hardware = {
  #   graphics = {
  #     enable = true;
  #     enable32Bit = true;
  #   };
  # };

  # enable passwordless sudo
  security.sudo = {
    extraRules = [
      {
        users = [ "kinzoku" ];
        commands = [
          {
            command = "ALL";
            options = [
              "SETENV"
              "NOPASSWD"
            ];
          }
        ];
      }
    ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users.${userinfo.name} = {
      isNormalUser = true;
      description = "Kira";
      extraGroups = [
        "networkmanager"
        "wheel"
        "qemu-libvirtd"
        "libvirtd"
        "disk"
        "docker"
        "jackaudio"
        "keyd"
      ];
      packages = with pkgs; [
        tree
      ];
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys.keys = lib.custom.getSSHPubkeyList userinfo.handles.github "05fiawl1gaspx3fdg75kf3cv97bpfbl5zlwl035kalx09b33vxmy";
    };
    users.root = {
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys.keys = lib.custom.getSSHPubkeyList userinfo.handles.github "05fiawl1gaspx3fdg75kf3cv97bpfbl5zlwl035kalx09b33vxmy";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      neovim
      git
      prismlauncher
      r2modman
      libreoffice
      vscodium
      feishin
      obsidian
      jetbrains.idea-community
      gcc

      lua-language-server
      stylua
      typescript-language-server
      vscode-langservers-extracted
      nil
      eslint
      ruff
      pyright
      jdt-language-server
      kotlin-language-server
      editorconfig-checker
      black
      gdtoolkit_4
      gofumpt
      gotools
      hclfmt
      isort
      ktlint
      ktfmt
      markdownlint-cli
      mdformat
      nixfmt-rfc-style
      pgformatter
      prettierd
      rustywind
      shfmt
      python312Packages.sqlfmt
      treefmt
      yamlfix
      golangci-lint
      tfsec
      dotenv-linter
      yamllint
      nodePackages_latest.nodejs
      statix
      deadnix
      yaml-language-server

      tmux

      thunderbird

      signal-desktop

      dmidecode
      lazygit

      handbrake
      ffmpeg_6-full

      fastfetch

      imagemagick

      ripgrep

      mullvad-vpn

      kitty
      nmap
      inetutils

      twingate

      jdk17

      mangareader

      pulsemixer

      unzip

      zoxide
      tldr
      scc
      eza
      duf
      aria2
      bat
      diff-so-fancy
      entr
      exiftool
      fdupes
      hyperfine
      just
      jq
      yq-go
      xq-xml
      tomlq
      more
      procs
      rip2
      rsync
      sd
      tre-command
      bandwhich
      btop
      glances
      gping
      dua
      speedtest-cli
      dogdns
      buku
      khal
      neomutt
      newsboat
      rclone
      taskwarrior3
      taskwarrior-tui
      httpie
      ctop
      lazydocker
      kdash
      kubectl
      minikube
      fluxcd
      talosctl
      asdf-vm
      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components;
        [
          gke-gcloud-auth-plugin
        ]
      ))

      virt-manager

      grc

      nfs-utils

      mumble

      nixd

      weechat

      sshfs

      gimp

      python3
      python312Packages.pip
      pipx
      multipath-tools
      openssl

      termsonic

      arduino-ide
      arduino-cli
      arduino
      arduino-language-server

      vlc
      qbittorrent

      libclang

      pkg-config
      libudev-zero

      reaper
      tunefish

      lumafly

      dpkg

      osu-lazer-bin

      musescore
      lmms

      xp-pen-g430-driver

      krita

      godot

      dotnetCorePackages.dotnet_8.sdk
      jetbrains.rider
      halloy
    ];
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
    variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji

    # (nerdfonts.override {
    #   fonts = [
    #     "JetBrainsMono"
    #     "NerdFontsSymbolsOnly"
    #   ];
    # })
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    geist-font
  ];

  nix = {
    settings = {
      cores = 8;
      max-jobs = 12;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  programs = {
    firefox.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      platformOptimizations.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    noisetorch.enable = true;
    nix-ld.enable = true;

    fuse = {
      userAllowOther = true;
    };
    # niri = {
    #   enable = true;
    #   package = pkgs.niri-unstable;
    # };
    gamemode.enable = true;
  };

  virtualisation = {
    waydroid.enable = true;
    libvirtd = {
      enable = true;
      extraConfig = ''
        user="kinzoku"
      '';

      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
      };
    };
    docker = {
      enable = true;
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 kinzoku qemu-libvirtd -"
    "f /dev/shm/scream 0660 kinzoku qemu-libvirtd -"
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
      packageOverrides = pkgs: {
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
        #   .overrideAttrs (old: {
        #     desktopItems = [
        #       (pkgs.makeDesktopItem {
        #         name = "steam";
        #         desktopName = "Steam (mullvad-exclude)";
        #         exec = "mullvad-exclude steam";
        #         icon = "steam";
        #     })
        #   ];
        # });
        # the custom desktop entry is in modules/home-manager/xdg.nix
      };
    };
    overlays = [
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
      # inputs.niri.overlays.niri
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
