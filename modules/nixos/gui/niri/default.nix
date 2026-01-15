{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri-nix.nixosModules.default
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri.overrideAttrs (o: {
      # TAKEN FROM https://github.com/iynaix/dotfiles/blob/eccb2940f5885c52759f7c2ccead197d515332e4/modules/gui/niri/default.nix#L39-L49
      patches =
        (o.patches or [])
        ++ [
          # fix fullscreen windows have a black background
          # https://github.com/YaLTeR/niri/discussions/1399#discussioncomment-12745734
          ./transparent-fullscreen.patch # https://github.com/iynaix/dotfiles/blob/eccb2940f5885c52759f7c2ccead197d515332e4/modules/gui/niri/transparent-fullscreen.patch
        ];
    });
    withUWSM = true;
  };

  hm.home.shellAliases = {
    niri-log = ''journalctl --user -u niri --no-hostname -o cat | awk '{$1=""; print $0}' | sed 's/^ *//' | sed 's/\x1b[[0-9;]*m//g' '';
  };
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
      WEBKIT_DISABLE_DMABUF_RENDERER = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
