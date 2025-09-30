{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    environment = { };
    font = {
      name = "JetBrains Mono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
    theme = "Catppuccin-Frappe";
    settings = {
      enable_audio_bell = false;
      window_padding_width = 2;
      confirm_os_windows_close = 0;
      disable_ligatures = "never";
    };
  };
}
