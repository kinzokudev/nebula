{
  config,
  lib,
  ...
}:
{
  options.custom = {
    zoxide = {
      enable = lib.mkEnableOption "zoxide" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.custom.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.custom.fish.enable;
    };
  };
}
