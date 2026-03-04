{
  flake.nixosModules.gui = {
    programs.firefox = {
      # Enable Firefox browser
      enable = true;
    };
  };
}
