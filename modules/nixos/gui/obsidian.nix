{
  flake.nixosModules.gui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      obsidian # Markdown-based notes app
    ];
  };
}
