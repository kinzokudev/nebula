{
  config,
  lib,
  pkgs,
  userinfo,
  ...
}: {
  options.custom = {
    vms = {
      enable = lib.mkEnableOption "virtual machines";
    };
  };
  config = lib.mkIf config.custom.vms.enable {
    virtualisation.libvirtd = {
      # Enable libvirtd daemon for VMs
      enable = true;
      # Set user
      extraConfig = ''
        user="${userinfo.name}"
      '';

      # Other configuration
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
      };
    };
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${userinfo.name} qemu-libvirtd -"
      "f /dev/shm/scream 0660 ${userinfo.name} qemu-libvirtd -"
    ];

    environment.systemPackages = with pkgs; [
      virt-manager # Desktop virtual machine manager
    ];
  };
}
