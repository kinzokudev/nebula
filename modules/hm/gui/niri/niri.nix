{
  pkgs,
  lib,
  config,
  ...
}: {
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
          width = 4;
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
        {
          geometry-corner-radius = 8;
          clip-to-geometry = true;
        }
      ];

      layer-rule = [
      ];

      binds =
        import ./binds.nix {inherit config;}
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+${toString (lib.mod (x + 1) 10)}" {focus-workspace = x + 1;})
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+Shift+${toString (lib.mod (x + 1) 10)}" {move-window-to-workspace = x + 1;});
    };
  };
}
