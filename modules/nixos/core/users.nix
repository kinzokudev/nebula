{
  pkgs,
  userinfo,
  ...
}: {
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      ${userinfo.name} = {
        isNormalUser = true;
        description = "${userinfo.fullname}";
        # Add user to groups
        extraGroups = [
          "networkmanager"
          "wheel"
          "disk"
        ];
        ignoreShellProgramCheck = true;
      };
      root = {
        ignoreShellProgramCheck = true;
      };
    };
  };
}
