{
  pkgs,
  config,
  lib,
  ...
}: {
  options.custom = {
    kitty = {
      enable =
        lib.mkEnableOption "kitty"
        // {
          default = true;
        };
    };
  };
  config = lib.mkIf config.custom.kitty.enable {
    programs.kitty = {
      enable = true;
      environment = {};
      font = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
        size = 12;
      };
      themeFile = "Catppuccin-Macchiato";
      settings = {
        enable_audio_bell = false;
        window_padding_width = 2;
        confirm_os_window_close = 0;
        disable_ligatures = "never";
      };
    };
  };
}
