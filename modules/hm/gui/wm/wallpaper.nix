{
  services.swww = {
    enable = true;
  };

  home.file."Pictures/wallpapers" = {
    source = ../../../../assets/wallpapers;
    recursive = true;
  };
}
