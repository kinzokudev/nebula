{
  pkgs,
  config,
  lib,
  ...
}: {
  options.custom = {
    audio = {
      enable =
        lib.mkEnableOption "audio"
        // {
          default = true;
        };
    };
    noisetorch = {
      enable = lib.mkEnableOption "NoiseTorch";
    };
  };
  config = lib.mkIf config.custom.audio.enable {
    security.rtkit.enable = true; # Enable RTKit
    services.pipewire = {
      enable = true; # Enable PipeWire
      alsa = {
        enable = true; # Enable ALSA through PipeWire
        support32Bit = true;
      };
      pulse.enable = true; # Enable PulseAudio through PipeWire
      jack.enable = true; # Enable JACK through PipeWire

      extraLv2Packages = with pkgs; [
        lsp-plugins
        rnnoise-plugin
      ];
    };

    programs.noisetorch = {
      inherit (config.custom.noisetorch) enable; # Enable NoiseTorch
    };

    environment.systemPackages = with pkgs; [
      pulsemixer # TUI mixer for PulseAudio
      pavucontrol # PulseAudio volume control
    ];

    hm.home.shellAliases = {
      pm = "pulsemixer";
    };
  };
}
