{
  config,
  lib,
  ...
}: {
  options.custom = {
    printing = {
      enable = lib.mkEnableOption "printing";
    };
  };
  config = lib.mkIf config.custom.printing.enable {
    services.printing = {
      # Enable CUPS daemon for printing
      enable = true;
    };
  };
}
