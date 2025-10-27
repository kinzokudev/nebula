{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    audacity = {
      enable = lib.mkEnableOption "Audacity";
    };
  };
  config = lib.mkIf config.custom.audacity.enable {
    environment.systemPackages = with pkgs; [
      audacity # Audio editor
    ];
  };
}
