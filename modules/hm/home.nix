{userinfo, ...}: {
  home = {
    username = "${userinfo.name}";
    homeDirectory = "/home/${userinfo.name}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
}
