{lib, ...}: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
      };
      timeout = 3;
    };
    supportedFilesystems.ntfs = true;
  };

  # faster boot times
  systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];

  # reduce journald logs
  services.journald.extraConfig = ''SystemMaxUse=50M'';
}
