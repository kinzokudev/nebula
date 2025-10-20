{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    cli = {
      network = lib.mkEnableOption "network tools";
      media = lib.mkEnableOption "media tools";
      dev = lib.mkEnableOption "dev tools";
    };
  };

  config = {
    environment.systemPackages =
      with pkgs;
      [
        wget # Tool for retrieving files using HTTP, HTTPS, and FTP
        fastfetch # System information tool /// Fork of Neofetch (deprecated)
        vim # Terminal-based text editor /// Based on vi
        neovim # Highly extensible terminal-based text editor /// Fork of Vim
        tmux # Terminal multiplexer
        btop # TUI resource monitor

        grc # Generic text colorizer
        dmidecode # Tool that reads info about system hardware from BIOS according to the SMBIOS/DMI standard
        libudev-zero # Daemonless replacement for libudev
        libclang # C language family frontend for LLVM
      ]
      ++ (
        with pkgs;
        lib.lists.optionals config.custom.cli.dev [
          stylua # Lua formatter
          lua-language-server # Lua langserver
          statix # Nix linter
          deadnix # Nix tool that scans for unused code
          alejandra # Nix formatter
          nixd # Nix langserver
          markdownlint-cli # Markdown linter
          mdformat # Markdown formatter
          dotenv-linter # Dotenv linter
          editorconfig-checker # Editorconfig linter
          yamllint # YAML linter
          shfmt # Shell parser and formatter
          prettierd # Multi-lang opinionated formatter
          eslint_d # JavaScript linter
          vscode-langservers-extracted # HTML/CSS/JSON/ESLint langservers from VSCode
          typescript-language-server # TypeScript langserver
          treefmt # Unified CLI tool for running multiple code formatters on the full source tree

          glow # CLI Markdown viewer
          ripgrep # Line-oriented CLI search tool that recursively searches the CWD for a regex pattern
          unzip # Extracts .zip archives
          just # Project command runner
          openssl # Cryptographic library that implements the SSL and TLS protocols
          pkg-config # Tool that allows packages to find out information about other packages

          gcc # GNU C compiler
          python3 # Python language v3
          python312Packages.pip # PyPA recommended tool for installing Python packages
        ]
      )
      ++ (
        with pkgs;
        lib.lists.optionals config.custom.cli.media [
          ffmpeg_8-full # Multimedia framework and media transcoder
          imagemagick # Software suite for modifying bitmap images
        ]
      )
      ++ (
        with pkgs;
        lib.lists.optionals config.custom.cli.network [
          nfs-utils # NFS utilities
          sshfs # Allows remote filesystems to be mounted over SSH
          twingate # Client for Twingate ZTNA platform
        ]
      );
  };
}
