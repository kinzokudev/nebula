{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
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
        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
            bindings =
              {
                suffixes,
                prefixes,
                substitutions ? { },
              }:
              let
                replacer = lib.replaceStrings (lib.attrNames substitutions) (lib.attrValues substitutions);
                format =
                  prefix: suffix:
                  let
                    actual-suffix =
                      if lib.isList suffix.action then
                        {
                          action = lib.head suffix.action;
                          args = lib.tail suffix.action;
                        }
                      else
                        {
                          inherit (suffix) action;
                          args = [ ];
                        };

                    action = replacer "${prefix.action}-${actual-suffix.action}";
                  in
                  {
                    name = "${prefix.key}+${suffix.key}";
                    value.action.${action} = actual-suffix.args;
                  };
                pairs =
                  attrs: fn:
                  lib.concatMap (
                    key:
                    fn {
                      inherit key;
                      action = attrs.${key};
                    }
                  ) (lib.attrNames attrs);
              in
              lib.listToAttrs (pairs prefixes (prefix: pairs suffixes (suffix: [ (format prefix suffix) ])));
          in
          lib.attrsets.mergeAttrsList [

            {
              "Mod+P".action = spawn "fuzzel";
              "Mod+Return".action = spawn "kitty";
              "Mod+Shift+Z".action = spawn "kitty" "pulsemixer";

              "Mod+Shift+C".action = close-window;

              "Mod+Shift+S".action = screenshot;
              "Mod+Print".action = screenshot-window;
              "Print".action.screenshot-screen = { };

              "Mod+F".action = fullscreen-window;

              "XF86AudioRaiseVolume".action = sh "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
              "XF86AudioLowerVolume".action = sh "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
              "XF86AudioMute".action = sh "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
              "XF86MonBrightnessUp".action = sh "brightnessctl set 10%+";
              "XF86MonBrightnessDown".action = sh "brightnessctl set 10%-";

            }
            (bindings {
              suffixes = {
                "H" = "column-left";
                "J" = "window-down";
                "K" = "window-up";
                "L" = "column-right";
              };
              prefixes = {
                "Mod" = "focus";
                "Mod+Shift" = "move";
                "Mod+Ctrl" = "focus-monitor";
                "Mod+Shift+Ctrl" = "move-window-to-monitor";
              };
              substitutions = {
                "monitor-column" = "monitor";
                "monitor-window" = "monitor";
              };
            })
            {
              "Mod+V".action = switch-focus-between-floating-and-tiling;
              "Mod+Shift+V".action = toggle-window-floating;
            }
            (bindings {
              suffixes = builtins.listToAttrs (
                map (n: {
                  name = toString n;
                  value = [
                    "workspace"
                    (n + 1)
                  ]; # workspace 1 is empty; workspace 2 is the logical first.
                }) (lib.range 1 9)
              );
              prefixes."Mod" = "focus";
              prefixes."Mod+Ctrl" = "move-window-to";
            })
          ];
      };
    };
    fuzzel = {
      enable = true;
      settings.main.launch-prefix = "niri msg action spawn --";
      settings.main.terminal = "kitty";
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
