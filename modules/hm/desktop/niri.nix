{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];
  options.custom = {
    niri = {
      enable = lib.mkEnableOption "niri";
    };
  };
  config = lib.mkIf config.custom.niri.enable {
    home = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
      packages = with pkgs; [
        swaybg
        swayimg
        wlr-randr
        wl-clipboard
        wayland-utils
        libsecret
        cage
        gamescope
        xwayland-satellite-unstable
      ];
    };
    programs = {
      niri = {
        settings = {
          input = {
            keyboard = {
              xkb = {
                layout = "us";
              };
              numlock = true;
            };
            mouse = {
              accel-profile = "flat";
            };
          };
          outputs = {
            "DP-1" = {
              enable = true;
              focus-at-startup = true;
              mode = {
                width = 1920;
                height = 1080;
                refresh = 165.0;
              };
              position = {
                x = 1920;
                y = 0;
              };
            };
            "DP-2" = {
              enable = true;
              focus-at-startup = false;
              mode = {
                width = 1920;
                height = 1080;
                refresh = 165.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
          };

          spawn-at-startup =
            lib.map
            (cmd: {
              command = [
                "sh"
                "-c"
                cmd
              ];
            })
            [
              "systemctl --user reset-failed waybar.service"
              "systemctl --user restart waybar.service"
            ];

          binds = with config.lib.niri.actions; let
            sh = spawn "sh" "-c";
            bindings = {
              suffixes,
              prefixes,
              substitutions ? {},
            }: let
              replacer = lib.replaceStrings (lib.attrNames substitutions) (lib.attrValues substitutions);
              format = prefix: suffix: let
                actual-suffix =
                  if lib.isList suffix.action
                  then {
                    action = lib.head suffix.action;
                    args = lib.tail suffix.action;
                  }
                  else {
                    inherit (suffix) action;
                    args = [];
                  };

                action = replacer "${prefix.action}-${actual-suffix.action}";
              in {
                name = "${prefix.key}+${suffix.key}";
                value.action.${action} = actual-suffix.args;
              };
              pairs = attrs: fn:
                lib.concatMap (
                  key:
                    fn {
                      inherit key;
                      action = attrs.${key};
                    }
                ) (lib.attrNames attrs);
            in
              lib.listToAttrs (pairs prefixes (prefix: pairs suffixes (suffix: [(format prefix suffix)])));
          in
            lib.attrsets.mergeAttrsList [
              {
                "Mod+P".action = spawn "fuzzel";
                "Mod+Return".action = spawn "kitty";
                "Mod+Shift+Z".action = spawn "kitty" "pulsemixer";

                "Mod+Shift+C".action = close-window;

                "Mod+Shift+S".action = screenshot;
                "Mod+Print".action = screenshot-window;

                "Mod+F".action = fullscreen-window;

                "XF86AudioRaiseVolume".action = sh "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
                "XF86AudioLowerVolume".action = sh "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
                "XF86AudioMute".action = sh "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
                "XF86MonBrightnessUp".action = sh "brightnessctl set 10%+";
                "XF86MonBrightnessDown".action = sh "brightnessctl set 10%-";

                "Mod+O".action = toggle-overview;

                "Mod+W".action = sh (
                  builtins.concatStringsSep "; " [
                    "systemctl --user restart waybar.service"
                    "systemctl --user restart swaybg.service"
                  ]
                );
              }
              {
                "Mod+H".action = focus-column-or-monitor-left;
                "Mod+J".action = focus-window-or-workspace-down;
                "Mod+K".action = focus-window-or-workspace-up;
                "Mod+L".action = focus-column-or-monitor-right;

                "Mod+Shift+H".action = move-column-left; # move-column-left-or-to-monitor-left
                "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
                "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
                "Mod+Shift+L".action = move-column-right; # move-column-right-or-to-monitor-right

                # "Mod+Ctrl+H".action = { };
                "Mod+Ctrl+J".action = move-workspace-down;
                "Mod+Ctrl+K".action = move-workspace-up;
                # "Mod+Ctrl+L".action = { };

                "Mod+Home".action = focus-column-first;
                "Mod+End".action = focus-column-last;
                "Mod+Shift+Home".action = move-column-to-first;
                "Mod+Shift+End".action = move-column-to-last;

                "Mod+Left".action = focus-monitor-left;
                "Mod+Down".action = focus-monitor-down;
                "Mod+Up".action = focus-monitor-up;
                "Mod+Right".action = focus-monitor-right;

                "Mod+Shift+Left".action = move-column-to-monitor-left;
                "Mod+Shift+Down".action = move-column-to-monitor-down;
                "Mod+Shift+Up".action = move-column-to-monitor-up;
                "Mod+Shift+Right".action = move-column-to-monitor-right;

                "Alt+Tab".action = focus-column-right-or-first;
                "Alt+Shift+Tab".action = focus-column-left-or-last;

                "Mod+grave".action = focus-window-previous;

                "Mod+Tab".action = focus-workspace-previous;
              }
              # (bindings {
              #   suffixes = {
              #     "H" = "column-left";
              #     "J" = "window-down";
              #     "K" = "window-up";
              #     "L" = "column-right";
              #   };
              #   prefixes = {
              #     "Mod" = "focus";
              #     "Mod+Shift" = "move";
              #     "Mod+Ctrl" = "focus-monitor";
              #     "Mod+Shift+Ctrl" = "move-window-to-monitor";
              #   };
              #   substitutions = {
              #     "monitor-column" = "monitor";
              #     "monitor-window" = "monitor";
              #   };
              # })
              # {
              #   "Mod+V".action = switch-focus-between-floating-and-tiling;
              #   "Mod+Shift+V".action = toggle-window-floating;
              # }
              # (bindings {
              #   suffixes = builtins.listToAttrs (
              #     map (n: {
              #       name = toString n;
              #       value = [
              #         "workspace"
              #         n
              #       ]; # workspace 1 is empty; workspace 2 is the logical first.
              #     }) (lib.range 1 9)
              #   );
              #   prefixes."Mod" = "focus";
              #   prefixes."Mod+Ctrl" = "move-window-to";
              # })
            ];
        };
      };
      fuzzel = {
        enable = true;
        settings.main.launch-prefix = "niri msg action spawn --";
        settings.main.terminal = "kitty";
      };
    };
  };
}
# {
#   pkgs,
#   inputs,
#   config,
#   ...
# }:
# {
#   imports = [
#     inputs.niri.homeModules.niri
#   ];
#
#   programs.niri = {
#     settings = {
#       binds = with config.lib.niri.actions; {
#         "Mod+P".action = spawn "fuzzel";
#         "Mod+Return".action = spawn "kitty";
#         "Mod+Shift+Z".action = spawn "kitty" "pulsemixer";
#
#         "Mod+Shift+C".action = close-window;
#         "Mod+Shift+S".action = screenshot;
#         "Mod+F".action = fullscreen-window;
#         "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
#         "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
#         "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
#       };
#     };
#   };
# }

