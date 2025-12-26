{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    inkscape # Vector graphics editor
  ];
}
