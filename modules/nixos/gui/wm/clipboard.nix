{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe';
in {
  environment.systemPackages = with pkgs; [
    cliphist # clipboard history
    wl-clipboard
  ];

  custom = {
    shell.packages = {
      rofi-clipboard-history =
        /*
        sh
        */
        ''
          rofi \
            -modi clipboard:${getExe' pkgs.cliphist "cliphist-rofi-img"} \
            -theme "${config.hm.xdg.configHome}/rofi/window.rasi" \
            -show clipboard -show-icons
        '';
    };
  };

  hm.services.cliphist = {
    enable = true;
  };
}
