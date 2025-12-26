{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    thunderbird # E-Mail client
  ];
}
