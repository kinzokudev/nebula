{
  config,
  pkgs,
  userinfo,
  inputs,
  lib,
  hostname,
  ...
}:

{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "${userinfo.name}";
    homeDirectory = "/home/${userinfo.name}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";

    packages =
      with pkgs;
      [
        btop
        fd
        kubectl
        minikube

        helmfile
        fluxcd
        go-task
        krew
        cilium-cli
        talosctl
        kubeconform
        kustomize
        stern
        minijinja
        cowsay
        lolcat
      ]
      ++ [
        inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.gimp-with-plugins
      ];
    file = {
      ".curlrc".text = ''
        # When following a redirect, automatically set the previous URL as referer.
        referer = ";auto"

        # Retrying
        connect-timeout = 60
        max-time 120
        retry 3
        retry-delay 0
        retry-max-time 60
      '';
      ".gitconfig".text = ''
        [user]
          name = kinzokudev
          email = kin@kinzoku.dev
          signingKey = ${config.home.homeDirectory}/.ssh/id_ed25519.pub
        [gpg]
          format = ssh
        [format]
          signOff = true
        [core]
          autocrlf = input
          editor = nvim
          excludesfile = ${config.home.homeDirectory}/.gitignore_global
        [commit]
          gpgSign = true
        [merge]
          ff = only
        [pull]
          rebase = true
        [status]
          submoduleSummary = false
        [tag]
          gpgSign = true
          forceSignAnnotated = true
        [init]
          defaultBranch = main
        [filter "lfs"]
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
          required = true
          clean = git-lfs clean -- %f
        [url "ssh://git@github.com/"]
          pushInsteadOf = https://github.com/
        [push]
          autoSetupRemote = true
        [safe]
          directory = *
      '';
      ".gitignore_global".text = ''
        *~
        .DS_Store
        Thumbs.db
        unittest.xml
      '';
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  xdg = {
    configFile = {
      "starship.toml".source = ./starship.toml;
      "bat/config".text = ''
        --theme Dracula
        --paging=never
        --style plain
      '';
      "lazygit/config.yml".text = ''
        gui:
          nerdFontsVersion: "3"
        git:
          commit:
            signOff: true
      '';
    };
  };
  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    fish = {
      enable = true;
      shellAbbrs = {
        tx = "tmux";
        txn = "tmux new";
        txa = "tmux attach";
        txd = "tmux detach";
        txk = "tmux kill-session";
        txl = "tmux list-sessions";
        dv = "direnv";
        dva = "direnv allow";
        dvs = "direnv status";
        dvk = "direnv revoke";
        dvr = "direnv reload";
        ".." = "cd ..";
        tfmt = "treefmt";
        rb = "sudo nixos-rebuild switch --flake .";
        fu = "sudo nix flake update";
        ga = "git add .";
        gc = "git commit -m";
        gp = "git push -u origin";
        lg = "lazygit";
        az = "yazi";
        nf = "neofetch";
        ff = "fastfetch";
        cl = "clear";
        pm = "pulsemixer";
        v = "fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim";
        udm = "udisksctl mount -b";
        udu = "udisksctl unmount -b";
        fgk = "flux get ks";
        fgka = "flux get ks -A";
        fgkn = "flux get ks -n";
        fgh = "flux get hr";
        fgha = "flux get hr -A";
        fghn = "flux get hr -n";
        tfp = "terraform plan";
        tfa = "terraform apply";
        tfi = "terraform init";
        tff = "terraform fmt";
        cat = "bat";
        "co" = {
          expansion = "checkout";
          command = "git";
        };
        "pl" = {
          expansion = "pull --rebase --autostash";
          command = "git";
        };
        "pf" = {
          expansion = "push --force";
          command = "git";
        };
        krew = "kubectl krew";
      };
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings

        ${pkgs.kubectl}/bin/kubectl completion fish | source
        ${pkgs.fluxcd}/bin/flux completion fish | source
        ${pkgs.talosctl}/bin/talosctl completion fish | source
        ${pkgs.minikube}/bin/minikube completion fish | source
      '';
      shellInit =
        let
          homedir = config.home.homeDirectory;
        in
        ''

          set -gx KUBE_EDITOR nvim
          set -gx VISUAL nvim
          set -gx EDITOR nvim
          set -gx GOPATH ${homedir}/.go
          set -gx ANSIBLE_FORCE_COLOR true
          set -gx ANSIBLE_HOST_KEY_CHECKING False
          set -gx PY_COLORS true
          set -gx GPG_TTY (tty)
          set -gx LANG en_US.utf-8

          if type -q mise
            if test "$VSCODE_RESOLVING_ENVIRONMENT" = 1
              ${pkgs.mise}/bin/mise activate fish --shims | source
            else if status is-interactive
              ${pkgs.mise}/bin/mise activate fish | source
            else
              ${pkgs.mise}/bin/mise activate fish --shims | source
            end
          end

          fish_add_path --global ${homedir}/.krew/bin
          fish_add_path ${homedir}/.local/bin
          fish_add_path ${homedir}/.cargo/bin
          fish_add_path ${homedir}/.krew/bin
          fish_add_path ${homedir}/.go/bin
        '';
      plugins = [
        {
          name = "kubectl-fish-abbr";
          src = pkgs.fetchFromGitHub {
            owner = "DrPhil";
            repo = "kubectl-fish-abbr";
            rev = "ebc68dfb0679e1d57209cef4d02f2214d3cfe783";
            hash = "sha256-5BBBkFcMYf1h7wn4Qv3umfEFqvlNezy9hbYH52NT1QY=";
          };
        }
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
        {
          name = "zoxide.fish";
          src = pkgs.fetchFromGitHub {
            owner = "kidonng";
            repo = "zoxide.fish";
            rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
            hash = "sha256-Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
          };
        }
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
        "commit" = {
          description = "git conventional commits";
          body = ''
            if test (count $argv) -gt 0
              set title $argv[1]
              set description $argv[2..-1]
              if not string length -q $description
                printf "Whoops you are missing a commit message" | cowsay | lolcat
                return
              end
              set short (string trim (string split "//" "$description" -f1))
              set long (string trim (string split "//" "$description" -m1 -f2))
              if string match -q '*-*' $title
                set type (string trim (string split "-" "$title" -f1))
                set scope (string trim (string split "-" "$title" -m1 -f2))
                set title "$type($scope)"
                if string match -q '*!' "$scope"
                  set scope (string trim --chars="!" $scope)
                  set title "$type($scope)!"
                end
              end
              if not string length -q $long
                git commit -s -m "$title: $short"
              else
                git commit -s -m "$title: $short" -m "$long"
              end
            else
              set title (curl -sL https://whatthecommit.com/index.txt)
              set short (curl -sL https://whatthecommit.com/index.txt)
              set long "Commit generated by whatthecommit.com"
              git commit -s -m "$title: $short" -m "$long"
            end
            printf "%s: %s\n\n%s" $title $short $long | cowsay | lolcat
          '';
        };
        "kubecolor" = {
          wraps = "kubectl";
          body = ''
            ${pkgs.kubecolor}/bin/kubecolor $argv
          '';
        };
        "kubectl" = {
          wraps = "kubectl";
          body = ''
            if type -q kubecolor
              ${pkgs.kubecolor}/bin/kubecolor $argv
            else
              ${pkgs.kubectl}/bin/kubectl $argv
            end
          '';
        };
        "ms" = {
          wraps = "mise";
          description = "mise shorthand";
          body =
            if hostname == "phone-01" then
              # Ref: https://github.com/jdx/mise/issues/1969
              ''
                proot -b $PREFIX/etc/resolv.conf:/etc/resolv.conf -b $PREFIX/etc/tls:/etc/ssl mise $argv
              ''
            else
              ''
                ${pkgs.mise}/bin/mise $argv
              '';
        };
        "tf" = {
          wraps = "terraform";
          description = "terraform shorthand";
          body =
            if hostname == "phone-01" then
              ''
                proot -b $PREFIX/etc/resolv.conf:/etc/resolv.conf terraform $argv
              ''
            else
              ''
                ${pkgs.terraform}/bin/terraform $argv
              '';
        };
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

    zoxide = {
      enable = true;
    };
    # thefuck = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    mise = {
      enable = true;
      enableFishIntegration = false;
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = true;
    };
    atuin = {
      enable = true;
      enableFishIntegration = true;
      flags = [
        "--disable-up-arrow"
      ];
      settings = {
        enter_accept = false;
      };
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
    hyfetch = {
      enable = true;
      settings = {
        preset = "lesbian";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    mangohud = {
      enable = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
