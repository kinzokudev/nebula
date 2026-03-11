{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.host-nova = {
    imports = with self.nixosModules; [
      gui
      wm

      chat
      lmms
      mullvad
      plasma
      gaming
      qbittorrent
      vm

      bluetooth
      keyd
      openrgb
    ];
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "192.168.40.20"
    ];

    nix.settings = {
      cores = 6;
      max-jobs = 4;
    };
  };
}
