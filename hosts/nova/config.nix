{
  custom = {
    cli = {
      dev = true;
      network = true;
      media = true;
    };
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
