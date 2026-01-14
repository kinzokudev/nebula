{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.deltachat-desktop
  ];
}
