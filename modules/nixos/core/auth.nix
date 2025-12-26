{
  lib,
  pkgs,
  userinfo,
  config,
  ...
}:
lib.mkMerge [
  # SSH settings
  {
    # Configure OpenSSH
    services.openssh = {
      enable = true;
      allowSFTP = true; # Enable SFTP and SSHFS support

      settings = {
        PasswordAuthentication = false; # Disable password auth
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no"; # Disable root login
      };
    };

    # Set authorized SSH keys for root and user
    users.users = let
      keyFiles = lib.map (x: "${./.}/keys/" + x) (builtins.attrNames (
        lib.filterAttrs (_: v: v == "regular") (builtins.readDir "${./.}/keys")
      ));
    in {
      root.openssh.authorizedKeys.keyFiles = keyFiles;
      ${userinfo.name}.openssh.authorizedKeys.keyFiles = keyFiles;
    };
  }
  # keyring settings
  {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  }
  # WM agnostic polkit authentication agent
  {
    systemd.user.services.polkit-gnome = {
      wantedBy = ["graphical-session.target"];

      unitConfig = {
        Description = "GNOME PolicyKit Agent";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      serviceConfig = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      };
    };
  }
  # misc
  {
    security = {
      polkit.enable = true;

      sudo.extraConfig = "Defaults passwd_tries=10";
    };

    environment.variables = {
      GNUPGHOME = "${config.hm.xdg.dataHome}/.gnupg";
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  }
]
