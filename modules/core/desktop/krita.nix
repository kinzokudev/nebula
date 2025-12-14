{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    krita = {
      enable = lib.mkEnableOption "Krita";
    };
  };
  config = lib.mkIf config.custom.krita.enable {
    environment.systemPackages = with pkgs; [
      krita # FOSS painting application
    ];
  };
}
