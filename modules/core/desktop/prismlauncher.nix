{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    prismlauncher = {
      enable = lib.mkEnableOption "Prism Launcher";
    };
  };
  config = lib.mkIf config.custom.prismlauncher.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher # FOSS Minecraft launcher
    ];
  };
}
