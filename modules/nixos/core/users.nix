{
  flake.nixosModules.core = {
    pkgs,
    userinfo,
    ...
  }: {
    users = {
      defaultUserShell = pkgs.fish;
      users = {
        root = {
          ignoreShellProgramCheck = true;
        };
        ${userinfo.name} = {
          isNormalUser = true;
          description = "${userinfo.fullname}";
          extraGroups = [
            "networkmanager"
            "wheel"
            "disk"
          ];
          ignoreShellProgramCheck = true;
        };
      };
    };
  };
}
