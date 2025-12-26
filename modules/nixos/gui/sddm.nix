{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "macchiato";
      accent = "lavender";
      font = "JetBrainsMono Nerd Font";
      fontSize = "12";
      background = "${../../../assets/wallpapers/dmc5_vergil_awakens.jpg}";
      loginBackground = true;
    })
  ];

  services.displayManager.sddm = {
    # Enable SDDM display manager
    enable = true;
    theme = "catppuccin-macchiato-lavender";
  };
}
