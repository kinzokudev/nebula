{
  flake.nixosModules.chat = {
    hm.services.easyeffects = {
      enable = true;
    };
    hm.xdg.configFile."easyeffectsrc".text = ''
      [UiSettings]
      ColorScheme=CatppuccinMacchiatoLavender
    '';
  };
}
