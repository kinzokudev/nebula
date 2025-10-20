{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    r2modman = {
      enable = lib.mkEnableOption "r2modman";
    };
  };
  config = lib.mkIf config.custom.r2modman.enable {
    environment.systemPackages = with pkgs; [
      r2modman # Thunderstore mod manager
    ];
  };
}
