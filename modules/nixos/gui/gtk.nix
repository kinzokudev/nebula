{pkgs, ...}: {
  hm.gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
    cursorTheme = {
      name = "catppuccin-macchiato-lavender-cursors";
      package = pkgs.catppuccin-cursors.macchiatoLavender;
    };
    theme = {
      name = "catppuccin-macchiato-lavender-standard";
      package = pkgs.catppuccin-gtk.override (_: {
        accents = [
          "lavender"
        ];
        variant = "macchiato";
      });
    };
  };
}
