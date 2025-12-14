{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    inkscape = {
      enable = lib.mkEnableOption "Inkscape";
    };
  };
  config = lib.mkIf config.custom.inkscape.enable {
    environment.systemPackages = with pkgs; [
      inkscape # Vector graphics editor
    ];
  };
}
