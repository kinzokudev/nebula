{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    reaper = {
      enable = lib.mkEnableOption "Reaper";
    };
  };
  config = lib.mkIf config.custom.reaper.enable {
    environment.systemPackages = with pkgs; [
      reaper # DAW
    ];
  };
}
