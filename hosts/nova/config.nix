{
  custom = {
    network = {
      hostname = "NOVA";
      extraDNS = [
        "192.168.40.20" # Local Pi-hole DNS
      ];
    };
    mullvad.enable = true;
    printing.enable = true;
    keyd.enable = true;
    sudo.passwordless = true;
    cli = {
      dev = true;
      network = true;
      media = true;
    };
    gpu = {
      enable = true;
      vendor = "amd";
    };
    obsidian.enable = true;
    thunderbird.enable = true;
    signal.enable = true;
    feishin.enable = true;
    r2modman.enable = true;
    prismlauncher.enable = true;
    lumafly.enable = true;
    osu.enable = true;
    gimp.enable = true;
    vlc.enable = true;
    qbittorrent.enable = true;
    firefox.enable = true;
    gnupg.enable = true;
    steam.enable = true;
    vms.enable = true;
    docker.enable = true;
  };
  hm.custom = {
    chromium.enable = true;
    discord.enable = true;
    mangohud.enable = true;
    niri.enable = true;
    obs.enable = true;
    waybar.enable = true;
    direnv.enable = true;
    git.dev = true;
  };

  nix.settings = {
    cores = 8;
    max-jobs = 12;
  };

  system.stateVersion = "24.11";

}
