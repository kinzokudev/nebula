{pkgs, ...}: {
  xdg.configFile."rofi/catppuccin-macchiato.rasi".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/rofi/refs/heads/main/themes/catppuccin-macchiato.rasi";
    sha256 = "sha256:0y7rp6crrhir6j4sslx2786kr1pid8pbgg1mq6kyds3w76cjv6ac";
  };
  xdg.configFile."rofi/config.rasi".text = ''
    @import "catppuccin-macchiato"
    configuration {
      font: "JetBrainsMono Nerd Font 12";
      location: 0;
      xoffset: 0;
      yoffset: 0;
    }
    @theme "catppuccin-macchiato"
  '';

  programs.rofi = {
    enable = true;
    theme = "catppuccin-macchiato";
    font = "JetBrainsMono Nerd Font 12";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
      rofi-nerdy
    ];
  };
}
