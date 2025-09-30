{
  pkgs,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      floating = {
        modifier = "Mod4";
      };
      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 11.0;
      };
      keybindings = {
        "${modifier}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty";
        "XF86AudioRaiseVolume" =
          "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%+ ; exec pkill -SIGRTMIN+10 i3blocks";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%- ; exec pkill -SIGRTMIN+10 i3blocks";
        "${modifier}+Shift+c" = "kill";
        "${modifier}+p" = "exec rofi-drun";
      };
    };
  };
}
