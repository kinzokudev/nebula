{
  custom = {
    cli = {
      dev = true;
      network = true;
      media = true;
    };
  };
  hm.custom = {
    chromium.enable = true;
    discord.enable = true;
    mangohud.enable = true;
    obs.enable = true;
    # waybar.enable = true;
    direnv.enable = true;
    git.dev = true;
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "192.168.40.20"
  ];

  nix.settings = {
    cores = 6;
    max-jobs = 4;
  };

  system.stateVersion = "24.11";
}
