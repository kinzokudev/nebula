{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    signal-desktop # E2EE messenger app
  ];
}
