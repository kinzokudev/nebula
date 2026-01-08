{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        enable_recursive_icon_lookup = true;
        ellipsize = "end";
        follow = "mouse";
        font = "JetBrainsMono Nerd Font 12";
        # frame_color = "#b7bdf8";
        # frame_width = 2;
        # background = "#24273a";
        # foreground = "#cad3f5";
      };

      urgency_low = {
        frame_width = 1;
        frame_color = "#b7bdf8";
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_normal = {
        frame_width = 2;
        frame_color = "#b7bdf8";
        background = "#24273a";
        foreground = "#cad3f5";
      };

      urgency_critical = {
        frame_width = 2;
        frame_color = "#ff2550";
        background = "#24273a";
        foreground = "#cad3f5";
      };
    };
  };

  home.packages = [
    pkgs.libnotify
  ];
}
