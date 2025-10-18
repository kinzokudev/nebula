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
      lsp = lib.mkEnableOption "LSPs/linters/formatters";
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
          nixfmt # Nix formatter (formerly nixfmt-rfc-style)
          mdformat # Markdown formatter
          shfmt # Shell parser and formatter
          nixd # Nix langserver

          treefmt # Unified CLI tool for running multiple code formatters on the full source tree
          ripgrep # Line-oriented CLI search tool that recursively searches the CWD for a regex pattern
          unzip # Extracts .zip archives
          just # Project command runner
          openssl # Cryptographic library that implements the SSL and TLS protocols
          pkg-config # Tool that allows packages to find out information about other packages
          twingate # Client for Twingate ZTNA platform
        ]
      )
      ++ (
        with pkgs;
        lib.lists.optionals config.custom.cli.lsp [
          lua-language-server # Lua langserver
          stylua # Lua formatter
          vscode-langservers-extracted # HTML/CSS/JSON/ESLint langservers from VSCode
          typescript-language-server # TypeScript langserver
          eslint # JavaScript linter
          ruff # Python linter/formatter
          pyright # Python type checker
          jdt-language-server # Java langserver
          kotlin-language-server # Kotlin langserver
          editorconfig-checker # Editorconfig linter
          black # Python formatter
          gdtoolkit_4 # GDScript parser/linter/formatter
          gofumpt # Golang formatter
          gotools # Golang toolkit
          hclfmt # HCL formatter
          isort # Python import sorter
          ktlint # Kotlin linter/formatter
          ktfmt # Kotlin formatter
          markdownlint-cli # Markdown linter
          pgformatter # PostgreSQL formatter
          prettierd # Multi-lang formatter
          rustywind # TailwindCSS class organizer
          python312Packages.sqlfmt # SQL formatter
          yamlfix # YAML formatter
          golangci-lint # Golang linter runner
          tfsec # Terraform security scanner
          dotenv-linter # Dotenv linter
          yamllint # YAML linter
          statix # Nix linter
          deadnix # Nix tool that scans for unused code
          yaml-language-server # YAML langserver

          gcc # GNU C compiler
          nodePackages_latest.nodejs # NodeJS
          jdk17 # Java Development Kit v17
          python3 # Python language v3
          python312Packages.pip # PyPA recommended tool for installing Python packages
          pipx # Install and run Python applications in isolated environments
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
        ]
      );
  };
}
