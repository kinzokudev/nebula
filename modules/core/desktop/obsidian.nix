{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    obsidian = {
      enable = lib.mkEnableOption "Obsidian";
    };
  };
  config = lib.mkIf config.custom.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian # Markdown-based notes app
    ];
  };
}
