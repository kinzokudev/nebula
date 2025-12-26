{
  # automount disks
  programs.dconf.enable = true;
  services.gvfs.enable = true;

  programs.fuse.userAllowOther = true;

  imports = [
    ./auth.nix
    ./boot.nix
    ./configuration.nix
    ./fonts.nix
    ./nix.nix
    ./users.nix
  ];
}
