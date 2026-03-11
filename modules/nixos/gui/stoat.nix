{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.stoat-desktop
  ];
}
