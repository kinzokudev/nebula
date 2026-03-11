{
  flake.nixosModules.core = {
    hm.programs.obs-studio = {
      enable = true;
    };
  };
}
