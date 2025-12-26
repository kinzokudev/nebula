{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    krita # FOSS painting application
  ];
}
