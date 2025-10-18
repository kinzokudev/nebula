{
  config,
  lib,
  ...
}:
{
  options.custom = {
    ssh = {
      enable = lib.mkEnableOption "SSH" // {
        default = true;
      };
    };
  };
  config = lib.mkIf config.custom.ssh.enable {
    services.openssh = {
      # Enable OpenSSH
      enable = true;
      allowSFTP = true; # Enable SFTP and SSHFS support

      settings = {
        PasswordAuthentication = false; # Disable password authentication for SSH
        PermitRootLogin = "no"; # Disallow root login for SSH
      };
    };
  };
}
