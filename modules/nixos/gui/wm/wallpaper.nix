{
  flake.nixosModules.wm = {
    hm.services.swww = {
      enable = true;
    };

    hm.home.file."Pictures/wallpapers" = {
      source = ../../../../assets/wallpapers;
      recursive = true;
    };
  };
}
