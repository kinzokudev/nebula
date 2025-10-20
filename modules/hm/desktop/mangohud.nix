{
  config,
  lib,
  ...
}: {
  options.custom = {
    mangohud = {
      enable = lib.mkEnableOption "mangohud";
    };
  };
  config = lib.mkIf config.custom.mangohud.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
