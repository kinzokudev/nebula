{inputs, ...}: let
  # include nixpkgs stable
  overlayStable = _: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (prev.pkgs) system;
      config.allowUnfree = true;
    };
  };
  # include custom packages
  overlayCustom = _: prev: {
    custom =
      (prev.custom or {})
      // (import ../packages {
        inherit (prev) pkgs;
        inherit inputs;
      });
  };
in {
  nixpkgs.overlays = [
    overlayStable
    overlayCustom
  ];
}
