{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    signal = {
      enable = lib.mkEnableOption "Signal";
    };
  };
  config = lib.mkIf config.custom.signal.enable {
    environment.systemPackages = with pkgs; [
      signal-desktop # E2EE messenger app
    ];
  };
}
