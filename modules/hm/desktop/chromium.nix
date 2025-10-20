{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    chromium = {
      enable = lib.mkEnableOption "chromium";
    };
  };

  config = lib.mkIf config.custom.chromium.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
