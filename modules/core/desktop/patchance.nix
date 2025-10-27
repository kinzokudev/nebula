{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    patchance = {
      enable = lib.mkEnableOption "patchance";
    };
  };
  config = lib.mkIf config.custom.patchance.enable {
    environment.systemPackages = with pkgs; [
      patchance # Audio patchbay
      python313Packages.legacy-cgi # dependency
    ];
  };
}
