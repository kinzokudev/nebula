{
  flake.nixosModules.core = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      bat
      git
      lazygit
    ];
    hm = {
      xdg = {
        configFile = {
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
          "starship.toml".source = ./starship.toml;
        };
      };
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          silent = true;
        };
        eza = {
          enable = true;
          enableFishIntegration = true;
          icons = "auto";
        };
        starship = {
          enable = true;
          enableFishIntegration = true;
        };
        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };
        fish = {
          enable = true;
          shellAbbrs = config.hm.home.shellAliases;
          interactiveShellInit = ''
            set fish_greeting
            fish_vi_key_bindings

            function yy
              set -l tmp (mktemp -t "yazi-cwd.XXXXX")
              command yazi $argv --cwd-file="$tmp"
              if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                builtin cd -- "$cwd"
              end
              rm -f -- "$tmp"
            end
          '';
          shellInit = let
            homedir = config.hm.home.homeDirectory;
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
                end
              '';
            };
          };
        };
        tmux = {
          enable = true;
          baseIndex = 1;
          keyMode = "vi";
          prefix = "C-a";
          sensibleOnTop = true;
          extraConfig = ''
            set -g mouse on
            set-option -g allow-rename off
            set -g escape-time 10

            unbind %
            bind | split-window -h -c "#{pane_current_path}"

            unbind '"'
            bind - split-window -v -c "#{pane_current_path}"

            unbind n
            bind-key n command-prompt -I "rename-window "

            unbind N
            bind-key N command-prompt -I "rename-session "

            unbind '&'
            bind C-x kill-window

            bind-key x kill-pane

            unbind r
            bind r source-file ~/.config/tmux/tmux.conf

            bind -n M-H previous-window
            bind -n M-L next-window
            bind -n S-Left previous-window
            bind -n S-Right next-window

            bind -n M-h select-pane -L
            bind -n M-j select-pane -D
            bind -n M-k select-pane -U
            bind -n M-l select-pane -R

            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy -n'

            set -g visual-activity off
            set -g visual-bell off
            set -g visual-silence off
            setw -g monitor-activity off
            set -g bell-action none

            # clock mode
            setw -g clock-mode-colour cyan

            # copy mode
            setw -g mode-style 'fg=black bg=blue bold'

            # panes
            set -g pane-border-style 'fg=blue'
            set -g pane-active-border-style 'fg=cyan'

            # statusbar
            set -g status-position bottom
            set -g status-justify left
            set -g status-style 'fg=blue'

            set -g status-left-style 'fg=brightcyan'
            set -g status-left '[#S] '
            set -g status-left-length 10

            set -g status-right-style 'fg=black bg=cyan'
            set -g status-right '%Y-%m-%d %H:%M '
            set -g status-right-length 50

            setw -g window-status-current-style 'fg=black bg=blue'
            setw -g window-status-current-format ' #I #W #F '

            setw -g window-status-style 'fg=blue bg=black'
            setw -g window-status-format ' #I #[fg=white]#W #[fg=cyan]#F '

            setw -g window-status-bell-style 'fg=cyan bg=blue bold'

            # messages
            set -g message-style 'fg=cyan bg=blue bold'

            # window and pane renumbering
            set -g renumber-windows on

            set-option -g history-limit 5000

            set -gq allow-passthrough on
          '';
          plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
            dracula
            yank
            tmux-fzf
          ];
        };
        yazi = {
          enable = true;
          plugins = {
            inherit
              (pkgs.yaziPlugins)
              full-border
              git
              smart-enter
              smart-paste
              ;
          };
          initLua =
            /*
            lua
            */
            ''
              require("full-border"):setup({ type = ui.Border.ROUNDED })
              require("git"):setup()
            '';

          settings = {
            log = {
              enabled = true;
            };
            mgr = {
              ratio = [
                0
                1
                1
              ];
              sort_by = "alphabetical";
              sort_sensitive = false;
              sort_reverse = false;
              linemode = "size";
              show_hidden = true;
            };
            opener = {
              # activate direnv before opening files
              # https://github.com/sxyazi/yazi/discussions/1083
              edit = [
                {
                  run = "direnv exec . $EDITOR $1";
                  block = true;
                }
              ];
            };
            # settings for plugins
            plugin = {
              prepend_fetchers = [
                {
                  id = "git";
                  name = "*";
                  run = "git";
                }
                {
                  id = "git";
                  name = "*/";
                  run = "git";
                }
              ];
            };
          };

          theme = {
            mgr = {
              preview_hovered = {
                underline = false;
              };
              folder_offset = [
                1
                0
                1
                0
              ];
              preview_offset = [
                1
                1
                1
                1
              ];
            };

            mode = {
              normal_main = {
                bg = "cyan";
              };
              # normal_alt = {
              #   bg = "cyan";
              # };
            };
          };

          keymap = {
            mgr.prepend_keymap = [
              # dropping to shell
              {
                on = "!";
                run =
                  /*
                  sh
                  */
                  ''
                    shell "$SHELL" --block --confirm
                  '';
                desc = "Open shell here";
              }
              # close input by a single Escape press
              {
                on = "<Esc>";
                run = "close";
                desc = "Cancel input";
              }
              # cd back to root of current git repo
              {
                on = [
                  "g"
                  "r"
                ];
                run =
                  /*
                  sh
                  */
                  ''
                    shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
                desc = "Cd to root of current git repo";
              }
              # smart-enter
              {
                on = "l";
                run = "plugin smart-enter";
                desc = "Enter the child directory, or open the file";
              }
              # smart-paste
              {
                on = "p";
                run = "plugin smart-paste";
                desc = "Paste into the hovered directory or CWD";
              }
            ];
          };
        };
      };
      home = {
        sessionVariables = {
          DIRENV_LOG_FORMAT = "";
        };
        shellAliases = {
          dv = "direnv";
          dva = "direnv allow";
          dvs = "direnv status";
          dvk = "direnv revoke";
          dvr = "direnv reload";
          ga = "git add .";
          gc = "git commit -m";
          gp = "git push -u origin";
          lg = "lazygit";
          tx = "tmux";
          txn = "tmux new";
          txa = "tmux attach";
          txd = "tmux detach";
          txk = "tmux kill-session";
          txl = "tmux list-sessions";
        };
        file = {
          ".gitconfig".text = ''
            [user]
              name = kinzokudev
              email = kin@kinzoku.dev
              signingKey = ${config.hm.home.homeDirectory}/.ssh/id_ed25519.pub
            [gpg]
              format = ssh
            [format]
              signOff = true
            [core]
              autocrlf = input
              editor = nvim
              excludesfile = ${config.hm.home.homeDirectory}/.gitignore_global
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
      };
    };
  };
}
