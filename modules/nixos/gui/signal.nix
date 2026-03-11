{
  flake.nixosModules.chat = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # E2EE messenger app
      (signal-desktop.overrideAttrs {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "signal";
            desktopName = "Signal";
            exec = "signal-desktop --password-store=\"kwallet6\"";
            icon = "signal-desktop";
            type = "Application";
            terminal = false;
            comment = "Private messaging from your desktop";
            startupWMClass = "signal";
            mimeTypes = [
              "x-scheme-handler/sgnl"
              "x-scheme-handler/signalcaptcha"
            ];
            categories = [
              "Network"
              "InstantMessaging"
              "Chat"
            ];
          })
        ];
      })
    ];
  };
}
