{
  config,
  lib,
  ...
}:
{
  options.custom = {
    firefox = {
      enable = lib.mkEnableOption "Firefox";
    };
  };
  config = lib.mkIf config.custom.firefox.enable {
    programs.firefox = {
      # Enable Firefox browser
      enable = true;
    };
  };
}
