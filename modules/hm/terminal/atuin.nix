{
  config,
  lib,
  ...
}:
{
  options.custom = {
    atuin = {
      enable = lib.mkEnableOption "atuin";
    };
  };

  config = lib.mkIf config.custom.atuin.enable {
    programs.atuin = {
      enable = true;
      enableFishIntegration = config.custom.fish.enable;
      flags = [
        "--disable-up-arrow"
      ];
      settings = {
        enter_accept = false;
      };
    };
  };
}
