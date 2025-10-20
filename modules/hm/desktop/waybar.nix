{
  config,
  lib,
  ...
}: {
  options.custom = {
    waybar = {
      enable = lib.mkEnableOption "waybar";
    };
  };
  config = lib.mkIf config.custom.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 32;
          margin-top = 4;
          margin-left = 4;
          margin-right = 4;
          spacing = 0;

          modules-left = ["niri/workspaces"];

          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              focused = "";
              default = "";
            };
          };
        };
      };
      style = let
        base = "303446";
        mantle = "292c3c";
        text = "c6d0f5";
      in ''
        * {
          border: none;
          font-family: JetBrainsMono Nerd Font, monospace;
          font-size: 14px;
        }

        window#waybar {
          background-color: #${mantle};
          color: #${text};
        }

        #workspaces {
          background-color: #${base};
        }

        #workspaces button {
          color: #${text};
        }

        #workspaces button.focused {
          color: #ba93ff;
        }
      '';
    };
  };
}
