{inputs, ...}: {
  imports = [
    inputs.niri-nix.nixosModules.default
  ];

  programs.niri = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
  };
}
