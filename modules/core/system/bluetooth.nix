{
  config,
  lib,
  ...
}: {
  options.custom = {
    bluetooth = {
      enable =
        lib.mkEnableOption "bluetooth"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.bluetooth.enable {
    hardware.bluetooth.enable = true; # Enable Bluetooth
    services.blueman.enable = true; # Enable Bluetooth Manager
  };
}
