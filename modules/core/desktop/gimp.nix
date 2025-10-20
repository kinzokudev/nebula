{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    gimp = {
      enable = lib.mkEnableOption "GIMP";
    };
  };
  config = lib.mkIf config.custom.gimp.enable {
    environment.systemPackages = with pkgs; [
      gimp # GNU Image Manipulation Program
    ];
  };
}
