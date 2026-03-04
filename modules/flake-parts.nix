{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.modules];

  systems = [
    # systems for building the `perSystem` attributes
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.nixfmt;
    # packages = (import ../packages) {inherit inputs pkgs;};
  };

  flake.options.wrapperModules = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Wrapper modules";
  };

  flake.options.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
    description = "Library functions / utilities";
  };
}
