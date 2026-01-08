{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.niri-nix.homeModules.default
  ];
  wayland.windowManager.niri = {
    enable = true;
    settings = {
      output = [
        {
          _args = ["DP-2"];
          mode = "1920x1080@164.834";
          position._props = {
            x = 0;
            y = 0;
          };
        }
        {
          _args = ["DP-1"];
          mode = "1920x1080@165.003";
          position._props = {
            x = 1920;
            y = 0;
          };
        }
      ];

      input = {
        keyboard = {
          xkb = {
            layout = "us,us,ru";
            variant = ",intl,";
          };
        };
        mouse = {
          accel-profile = "flat";
        };
        workspace-auto-back-and-forth = [];
      };

      layout = {
        gaps = 16;

        struts = {
          left = 8;
          right = 8;
          top = 8;
          bottom = 8;
        };

        focus-ring = {
          width = 2;
          active-color = "#6900ff";
          inactive-color = "#1e1e2e";
        };
        border.off = [];
        shadow = {
          on = [];
          offset._props = {
            x = 0.0;
            y = 5.0;
          };
          softness = 30;
          spread = 4;
          draw-behind-window = false;
          color = "#1a1a1aee";
        };
        tab-indicator = {
          hide-when-single-tab = [];
          gap = 0;
          width = 12;
          length._props = {
            total-proportion = 1.0;
          };
          position = "top";
          gaps-between-tabs = 0.0;
          corner-radius = 0.0;
        };
        default-column-width = {
          proportion = 0.5;
        };
        preset-column-widths._children = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
          {proportion = 1.0;}
        ];
        preset-window-heights._children = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
          {proportion = 1.0;}
        ];
        center-focused-column = "never";
        always-center-single-column = [];
      };

      prefer-no-csd = [];

      gestures = {
        hot-corners.off = [];
      };

      # cursor = {
      #   xcursor-theme = "";
      #   xcursor-size = "";
      # };

      screenshot-path = "${config.home.homeDirectory}/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S%z.png";

      # allows jumping to a window when clicking on notifications
      debug = {
        honor-xdg-activation-with-invalid-serial = [];
      };

      hotkey-overlay = {
        skip-at-startup = [];
      };

      clipboard = {
        disable-primary = [];
      };

      spawn-at-startup = ["swww" "img" "~/Pictures/wallpapers/wallpaper_01.png"];

      overview = {
        zoom = 0.4;
      };

      xwayland-satellite = {
        path = "${lib.getExe pkgs.xwayland-satellite}";
      };

      window-rule = [
        {
          draw-border-with-background = false;
          open-maximized-to-edges = false;
        }
      ];

      binds =
        {
          #|===|#
          "Mod+Return".spawn = "kitty";
          "Mod+P".spawn = ["rofi" "-show" "drun" "-theme" "~/.config/rofi/drun.rasi"];
          "Mod+Shift+P".spawn = ["rofi" "-show" "run" "-theme" "~/.config/rofi/run.rasi"];
          "Mod+E".spawn = ["rofi" "-show" "emoji" "-theme" "~/.config/rofi/emoji.rasi"];
          "Mod+Q".spawn = ["rofi" "-show" "calc" "-theme" "~/.config/rofi/calc.rasi"];
          "Mod+Shift+Z".spawn = ["kitty" "pulsemixer"];
          "Mod+N".spawn = ["dunstctl" "history-pop"];
          "Mod+Shift+N".spawn = ["dunstctl" "close"];
          #|===|#

          #|===|#
          "Mod+F".fullscreen-window = [];
          "Mod+Z".maximize-column = [];
          "Mod+R".switch-preset-column-width = [];
          "Mod+Shift+R".switch-preset-window-height = [];
          "Mod+Ctrl+R".reset-window-height = [];
          "Mod+C".center-column = [];
          "Mod+Shift+Q".toggle-overview = [];
          "Mod+T".toggle-window-floating = [];
          "Mod+Tab".switch-focus-between-floating-and-tiling = [];
          "Mod+W".toggle-column-tabbed-display = [];
          "Mod+Shift+C".close-window = [];
          #
          "Mod+BracketLeft".set-column-width = "-10%";
          "Mod+BracketRight".set-column-width = "+10%";
          "Mod+Shift+BracketLeft".set-window-height = "-10%";
          "Mod+Shift+BracketRight".set-window-height = "+10%";
          #
          "Mod+Shift+S".screenshot = [];
          "Shift+Print".screenshot-window = [];
          "Ctrl+Print".screenshot-screen = [];
          #
          "Mod+Shift+Escape".quit = [];
          "Mod+Escape".toggle-keyboard-shortcuts-inhibit = [];
          #|===|#

          #|===|#
          "Mod+H".focus-column-or-monitor-left = [];
          "Mod+J".focus-window-or-workspace-down = [];
          "Mod+K".focus-window-or-workspace-up = [];
          "Mod+L".focus-column-or-monitor-right = [];
          #
          "Mod+Shift+H".move-column-left-or-to-monitor-left = [];
          "Mod+Shift+J".move-column-to-workspace-down = [];
          "Mod+Shift+K".move-column-to-workspace-up = [];
          "Mod+Shift+L".move-column-right-or-to-monitor-right = [];
          #
          "Mod+Ctrl+H".focus-monitor-left = [];
          "Mod+Ctrl+J".focus-monitor-down = [];
          "Mod+Ctrl+K".focus-monitor-up = [];
          "Mod+Ctrl+L".focus-monitor-right = [];
          #
          "Mod+Shift+Ctrl+H".move-window-to-monitor-left = [];
          "Mod+Shift+Ctrl+J".move-window-to-monitor-down = [];
          "Mod+Shift+Ctrl+K".move-window-to-monitor-up = [];
          "Mod+Shift+Ctrl+L".move-window-to-monitor-right = [];
          #
          "Mod+A".focus-column-left-or-last = [];
          "Mod+S".focus-column-right-or-first = [];
          #
          "Mod+Comma".consume-or-expel-window-left = [];
          "Mod+Period".consume-or-expel-window-right = [];
          #|===|#

          #|===|#
          "XF86AudioRaiseVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05+"];
          "XF86AudioLowerVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05-"];
          "XF86AudioMute".spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
          #
          "XF86MonBrightnessUp".spawn = ["brightnessctl" "set" "5%+"];
          "XF86MonBrightnessDown".spawn = ["brightnessctl" "set" "5%-"];
          #|===|#

          # "MouseForward".focus-workspace-up = [];
          # "MouseBack".focus-workspace-down = [];

          "Mod+WheelScrollDown" = {
            _props = {
              cooldown-ms = 150;
            };
            focus-window-or-workspace-down = [];
          };
          "Mod+WheelScrollUp" = {
            _props = {
              cooldown-ms = 150;
            };
            focus-window-or-workspace-up = [];
          };

          # "Mod+H".focus-column-left-or-last = [];
          # "Mod+L".focus-column-right-or-first = [];
          # "Mod+Shift+H".move-column-left = [];
          # "Mod+Shift+L".move-column-right = [];
          # "Alt+H".focus-monitor-left = [];
          # "Alt+L".focus-monitor-right = [];
          # "Alt+Shift+H".move-column-to-monitor-left = [];
          # "Alt+Shift+L".move-column-to-monitor-right = [];
        }
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+${toString (lib.mod (x + 1) 10)}" {focus-workspace = x + 1;})
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+Shift+${toString (lib.mod (x + 1) 10)}" {move-window-to-workspace = x + 1;});
    };
  };
}
