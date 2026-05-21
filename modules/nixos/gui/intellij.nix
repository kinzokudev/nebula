{
  flake.nixosModules.gui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-oss # IntelliJ IDEA
    ];
  };
}
