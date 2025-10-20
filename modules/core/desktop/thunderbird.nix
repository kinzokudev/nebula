{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    thunderbird = {
      enable = lib.mkEnableOption "Thunderbird";
    };
  };
  config = lib.mkIf config.custom.thunderbird.enable {
    environment.systemPackages = with pkgs; [
      thunderbird # E-Mail client
    ];
  };
}
