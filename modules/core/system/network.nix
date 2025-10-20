{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    network = {
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Machine hostname";
      };
      extraDNS = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Extra DNS nameservers";
      };
    };
  };
  config = {
    networking = {
      hostName = "${config.custom.network.hostname}"; # Set machine hostname
      nameservers =
        [
          # Set DNS nameservers
          "1.1.1.1"
          "1.0.0.1"
        ]
        ++ config.custom.network.extraDNS;

      networkmanager.enable = true; # Enable NetworkManager
    };

    # Disable NetworkManager-wait-online.service (explained here https://forums.linuxmint.com/viewtopic.php?t=282437)
    systemd.services.NetworkManager-wait-online.enable = false;

    environment.systemPackages = with pkgs; [
      nmap # Network discovery utility
      inetutils # Collection of common network programs
    ];
  };
}
