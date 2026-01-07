{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs) callPackage;
in {
  rofi-themes = callPackage ./rofi-themes {};
}
