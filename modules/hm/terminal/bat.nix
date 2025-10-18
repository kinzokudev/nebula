{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    bat = {
      enable = lib.mkEnableOption "bat" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.custom.bat.enable {
    home.packages = with pkgs; [
      bat
    ];
    xdg.configFile = {
      "bat/config".text = ''
        --theme Dracula
        --paging=never
        --style plain
      '';
    };

  };
}
