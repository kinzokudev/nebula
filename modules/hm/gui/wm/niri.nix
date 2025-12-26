{
  lib,
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
          mode = "1920x1080@165";
          position._props = {
            x = 0;
            y = 0;
          };
        }
        {
          _args = ["DP-1"];
          mode = "1920x1080@165";
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
      };

      layout = {
        preset-column-widths._children = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
          {proportion = 1.0;}
        ];
        focus-ring.off = [];
      };

      binds =
        {
          "Mod+Return".spawn = "kitty";
          "Mod+P".spawn = ["rofi" "-show" "drun"];

          "Mod+Shift+C".close-window = [];

          "Mod+H".focus-column-left-or-last = [];
          "Mod+L".focus-column-right-or-first = [];
          "Mod+Shift+H".move-column-left = [];
          "Mod+Shift+L".move-column-right = [];
          "Alt+H".focus-monitor-left = [];
          "Alt+L".focus-monitor-right = [];
          "Alt+Shift+H".move-column-to-monitor-left = [];
          "Alt+Shift+L".move-column-to-monitor-right = [];
        }
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+${toString (lib.mod (x + 1) 10)}" {focus-workspace = x + 1;})
        // lib.genAttrs' (lib.genList lib.id 10) (x: lib.nameValuePair "Mod+Shift+${toString (lib.mod (x + 1) 10)}" {move-window-to-workspace = x + 1;});
    };
  };
}
