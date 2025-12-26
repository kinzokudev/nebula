{
  hostname,
  pkgs,
  lib,
  ...
}: {
  networking.hostName = hostname;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true; # use xkb.options in tty
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us,us,ru";
      variant = ",intl,";
    };
    # fuck you xterm
    excludePackages = [pkgs.xterm];
  };

  # fuck you nano
  programs.nano.enable = lib.mkForce false;

  # use dbus broker as the default implementation
  services.dbus.implementation = "broker";

  # enable opengl
  hardware.graphics.enable = true;

  # do not change this value
  # system.stateVersion = "25.11";
}
