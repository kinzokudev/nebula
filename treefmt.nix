{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    mdformat.enable = true;
    shfmt = {
      enable = true;
      indent_size = 4;
    };
  };
}
