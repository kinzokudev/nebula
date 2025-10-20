{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom = {
    mullvad = {
      enable = lib.mkEnableOption "Mullvad VPN";
    };
  };
  config = lib.mkIf config.custom.mullvad.enable {
    services.mullvad-vpn = {
      # Enable Mullvad VPN
      enable = true;
      package = pkgs.mullvad-vpn; # Default of `pkgs.mullvad` only includes CLI, `pkgs.mullvad-vpn` includes CLI and GUI
    };
  };
}
