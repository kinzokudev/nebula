{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lmms # DAW
    tunefish
  ];
}
