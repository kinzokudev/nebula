{
  config,
  lib,
  ...
}:
{
  options.custom = {
    obs = {
      enable = lib.mkEnableOption "OBS";
    };
  };
  config = lib.mkIf config.custom.obs.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
