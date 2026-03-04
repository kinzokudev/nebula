{
  flake.nixosModules.core = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkOption;
    inherit (lib.types) str;
  in {
    options.custom = {
      fonts = {
        regular = mkOption {
          type = str;
          default = "Geist";
          description = "The font to use for regular text";
        };
        monospace = mkOption {
          type = str;
          default = "JetBrainsMono Nerd Font";
          description = "The font to use for monospace text";
        };
      };
    };

    config = {
      fonts.fontconfig.enable = true;

      fonts = {
        enableDefaultPackages = true;

        packages = with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji

          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only
          geist-font
        ];
      };
    };
  };
}
