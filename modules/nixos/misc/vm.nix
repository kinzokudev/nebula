{
  pkgs,
  userinfo,
  ...
}: {
  virtualisation = {
    libvirtd.enable = true;
    # following configuration is used only when building VMs with build-vm
    vmVariant = {
      virtualisation = {
        memorySize = 1024 * 8;
        cores = 4;
      };
    };
  };
  programs.virt-manager.enable = true;
  # https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752/2
  # add virtiofsd to filesystem xml
  # <binary path="/run/current-system/sw/bin/virtiofsd"/>
  environment.systemPackages = with pkgs; [virtiofsd];

  users.users.${userinfo.name}.extraGroups = ["libvirtd"];
}
