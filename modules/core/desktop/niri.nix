{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = lib.mkIf config.hm.custom.niri.enable {
    enable = true;
    package = pkgs.niri.overrideAttrs {
      doCheck = false;
    };
  };
}
