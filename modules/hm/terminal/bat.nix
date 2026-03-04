{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
  ];
  xdg.configFile = {
    "bat/config".text = ''
      --theme Dracula
      --paging=never
      --style plain
    '';
  };
}
