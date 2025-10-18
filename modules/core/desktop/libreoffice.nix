{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    libreoffice = {
      enable = lib.mkEnableOption "LibreOffice";
    };
  };
  config = lib.mkIf config.custom.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice
    ];
  };
}
