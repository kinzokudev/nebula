{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin # Subsonic/Jellyfin compatible music player
    mpv
  ];
  nixpkgs.overlays = [
    (
      final: _: {
        feishin = final.callPackage ../../../packages/feishin/default.nix {};
      }
    )
  ];
}
