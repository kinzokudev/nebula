{
  config,
  lib,
  ...
}: {
  options.custom = {
    gnupg = {
      enable = lib.mkEnableOption "GnuPG";
    };
  };
  config = lib.mkIf config.custom.gnupg.enable {
    programs.gnupg.agent = {
      # Enable GnuPG agent
      enable = true;
      enableSSHSupport = true; # Enable SSH agent support in GnuPG agent
    };
  };
}
