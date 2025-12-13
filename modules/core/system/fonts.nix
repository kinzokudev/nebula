{pkgs, ...}: {
  # Install fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    geist-font
  ];
}
