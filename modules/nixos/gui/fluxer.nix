{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.custom.fluxer
  ];
}
