{
  config,
  lib,
  ...
}: {
  options.custom = {
    xserver = {
      enable =
        lib.mkEnableOption "xserver"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.xserver.enable {
    services.xserver = {
      # Enable xserver
      enable = true;
      xkb = {
        # 3 keyboard layouts || 1 US, 1 US intl, 1 RU
        layout = "us,us,ru";
        variant = ",intl,";
      };
    };
  };
}
