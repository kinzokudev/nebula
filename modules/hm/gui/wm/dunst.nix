{pkgs, ...}: {
  services.dunst = {
    enable = true;
  };

  home.packages = [
    pkgs.libnotify
  ];
}
