{
  pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
  },
  ...
}:
pkgs.mkShell {
  packages = with pkgs; [
    age
    sops
    cachix
    deadnix
    statix
    nixd
    nixfmt
    mdformat
    shfmt
    treefmt
    wlr-randr
  ];
}
