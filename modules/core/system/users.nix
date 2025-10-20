{
  config,
  lib,
  pkgs,
  userinfo,
  ...
}: {
  # Configure users
  users = let
    getSSHPubkeyList = username: sha256:
      lib.splitString "\n" (
        builtins.readFile (
          builtins.fetchurl {
            url = "https://github.com/${username}.keys";
            inherit sha256;
          }
        )
      );
  in {
    defaultUserShell =
      if config.hm.custom.fish.enable
      then pkgs.fish
      else pkgs.bash;
    users.${userinfo.name} = {
      isNormalUser = true;
      description = "${userinfo.fullname}";
      # Add user to groups
      extraGroups =
        [
          "networkmanager"
          "wheel"
          "disk"
          "${lib.optionalString config.custom.docker.enable "docker"}"
          "${lib.optionalString config.custom.audio.enable "jackaudio"}"
          "${lib.optionalString config.custom.keyd.enable "keyd"}"
        ]
        ++ (lib.lists.optionals config.custom.vms.enable [
          "qemu-libvirtd"
          "libvirtd"
        ]);
      ignoreShellProgramCheck = true;
      # Get SSH pubkeys from GitHub
      openssh.authorizedKeys.keys = getSSHPubkeyList userinfo.handles.github "05fiawl1gaspx3fdg75kf3cv97bpfbl5zlwl035kalx09b33vxmy";
    };
    users.root = {
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys.keys = getSSHPubkeyList userinfo.handles.github "05fiawl1gaspx3fdg75kf3cv97bpfbl5zlwl035kalx09b33vxmy";
    };
  };
}
