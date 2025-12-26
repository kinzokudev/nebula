{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    r2modman # Thunderstore mod manager
  ];
}
