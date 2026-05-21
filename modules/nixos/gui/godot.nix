{
  flake.nixosModules.godot = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      godotPackages_4_3.godot # Open-source game engine
      gdtoolkit_4 # Godot dev tools
    ];
  };
}
