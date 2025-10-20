{
  pkgs,
  config,
  lib,
  ...
}: {
  options.custom = {
    fish = {
      enable =
        lib.mkEnableOption "fish"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.fish.enable {
    home.shellAliases = {
      ".." = "cd ..";
      cl = "clear";
      cat = "bat";
      ff = "fastfetch";
    };
    programs.fish = {
      enable = true;
      shellAbbrs = config.home.shellAliases;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellInit = let
        homedir = config.home.homeDirectory;
      in ''
        set -gx VISUAL nvim
        set -gx EDITOR nvim
        set -gx GOPATH ${homedir}/.go
        set -gx PY_COLORS true
        set -gx GPG_TTY (tty)
        set -gx LANG en_US.utf-8

        fish_add_path ${homedir}/.local/bin
        fish_add_path ${homedir}/.cargo/bin
        fish_add_path ${homedir}/.go/bin
      '';
      plugins = [
        {
          name = "fish-ssh-agent";
          src = pkgs.fetchFromGitHub {
            owner = "danhper";
            repo = "fish-ssh-agent";
            rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
            hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
          };
        }
        {
          name = "fish-colored-man";
          src = pkgs.fetchFromGitHub {
            owner = "decors";
            repo = "fish-colored-man";
            rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
            hash = "sha256-uoZ4eSFbZlsRfISIkJQp24qPUNqxeD0JbRb/gVdRYlA=";
          };
        }
        {
          name = "bass";
          src = pkgs.fetchFromGitHub {
            owner = "edc";
            repo = "bass";
            rev = "v1.0";
            hash = "sha256-XpB8u2CcX7jkd+FT3AYJtGwBtmNcLXtfMyT/z7gfyQw=";
          };
        }
        {
          name = "done";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "1.19.3";
            hash = "sha256-DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
          };
        }
        (lib.mkIf config.custom.zoxide.enable {
          name = "zoxide.fish";
          src = pkgs.fetchFromGitHub {
            owner = "kidonng";
            repo = "zoxide.fish";
            rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
            hash = "sha256-Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
          };
        })
        {
          name = "autopair.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "1.0.4";
            hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
          };
        }
        {
          name = "puffer-fish";
          src = pkgs.fetchFromGitHub {
            owner = "nickeb96";
            repo = "puffer-fish";
            rev = "v1.0.0";
            hash = "sha256-2niYj0NLfmVIQguuGTA7RrPIcorJEPkxhH6Dhcy+6Bk=";
          };
        }
        {
          name = "spark.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "spark.fish";
            rev = "1.2.0";
            hash = "sha256-AIFj7lz+QnqXGMBCfLucVwoBR3dcT0sLNPrQxA5qTuU=";
          };
        }
        {
          name = "fzf.fish";
          src = pkgs.fetchFromGitHub {
            owner = "patrickf3139";
            repo = "fzf.fish";
            rev = "v10.3";
            hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
          };
        }
      ];
      functions = {
        "," = ''
          for pkg in $argv
              nix shell nixpkgs#$pkg
          end
        '';
        "watch" = {
          description = "watch with fish alias support";
          body = ''
            if test (count $argv) -gt 0
              if type -q viddy
                ${pkgs.viddy}/bin/viddy --disable_auto_save --differences --interval 2 --shell ${pkgs.fish}/bin/fish $argv[1..-1]
              else
                command watch -x ${pkgs.fish}/bin/fish -c "$argv"
              end
            else
          '';
        };
      };
    };
  };
}
