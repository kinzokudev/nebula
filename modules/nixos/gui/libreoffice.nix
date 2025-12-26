{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libreoffice # FOSS office suite
  ];
}
