{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    appimagerun = {
      enable = lib.mkEnableOption "appimage-run";
    };
  };
  config = lib.mkIf config.custom.appimagerun.enable {
    environment.systemPackages = with pkgs; [
      appimage-run
    ];
  };
}
