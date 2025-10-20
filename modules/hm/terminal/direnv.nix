{
  config,
  lib,
  ...
}: {
  options.custom = {
    direnv = {
      enable = lib.mkEnableOption "direnv";
    };
  };
  config = lib.mkIf config.custom.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
    home = {
      sessionVariables = {
        DIRENV_LOG_FORMAT = "";
      };
      shellAliases = {
        dv = "direnv";
        dva = "direnv allow";
        dvs = "direnv status";
        dvk = "direnv revoke";
        dvr = "direnv reload";
      };
    };
  };
}
