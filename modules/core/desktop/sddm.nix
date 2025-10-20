{
  config,
  lib,
  ...
}: {
  options.custom = {
    sddm = {
      enable =
        lib.mkEnableOption "SDDM"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.sddm.enable {
    services.displayManager.sddm = {
      # Enable SDDM display manager
      enable = true;
    };
  };
}
