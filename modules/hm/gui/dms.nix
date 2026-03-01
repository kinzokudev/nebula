{inputs, ...}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    # NOTE: khal is currently broken (https://github.com/pimutils/khal/issues/1455)
    enableCalendarEvents = false; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
  };
}
