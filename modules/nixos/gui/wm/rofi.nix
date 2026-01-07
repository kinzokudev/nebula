# based on: https://github.com/iynaix/dotfiles/blob/17529889d2c758fd983b85d738c0dc3ece570587/modules/gui/wm/rofi.nix
{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      rofi = prev.rofi.override {
        plugins = with pkgs; [
          custom.rofi-themes
          rofi-calc
          rofi-emoji
          rofi-nerdy
        ];
      };
    })
  ];

  hm.xdg.configFile = {
    "rofi/catppuccin-macchiato.rasi".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/refs/heads/main/themes/catppuccin-macchiato.rasi";
      sha256 = "sha256:0y7rp6crrhir6j4sslx2786kr1pid8pbgg1mq6kyds3w76cjv6ac";
    };
    "rofi/catppuccin-default.rasi".text = let
      ctpDefault = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/rofi/refs/heads/main/catppuccin-default.rasi";
          sha256 = "sha256:1f3r6yarrykj8cxvi5hblzlr5n8zbncifnxps9xl5gl32w6ysq5z";
        }
      );
    in ''
      @import "catppuccin-macchiato"

      ${ctpDefault}
    '';
    "rofi/config.rasi".text = ''
      configuration {
        font: "JetBrainsMono Nerd Font 12";
        location: 0;
        xoffset: 0;
        yoffset: 0;
      }
      @theme "catppuccin-default"
    '';
  };

  environment.systemPackages = [
    pkgs.rofi
  ];
}
