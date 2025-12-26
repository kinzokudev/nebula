{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    prismlauncher # FOSS Minecraft launcher
  ];
}
