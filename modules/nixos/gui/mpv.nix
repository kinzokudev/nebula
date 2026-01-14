{pkgs, ...}: {
  hm.programs.mpv = {
    enable = true;
    bindings = {
      MBTN_LEFT = "cycle pause";
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      RIGHT = "seek 10";
      LEFT = "seek -10";
      l = "seek 10";
      h = "seek -10";
      k = "seek 60";
      j = "seek -60";
      S = "cycle sub";
      "]" = "add speed 0.1";
      "[" = "add speed -0.1";

      I = ''cycle-values vf "sub,lavfi=negate" ""''; # invert colors

      # disable annoying defaults
      "1" = "ignore";
      "2" = "ignore";
      "3" = "ignore";
      "4" = "ignore";
      "5" = "ignore";
      "6" = "ignore";
      "7" = "ignore";
      "8" = "ignore";
      "9" = "ignore";
      "0" = "ignore";
      "/" = "ignore";
      "*" = "ignore";
      "Alt+left" = "ignore";
      "Alt+right" = "ignore";
      "Alt+up" = "ignore";
      "Alt+down" = "ignore";
    };
    config = {
      # recommended mpv settings can be referenced here:
      # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf
      profile = "gpu-hq";
      input-ipc-server = "/tmp/mpvsocket";
      # no-border = true;
      save-position-on-quit = true;
      force-seekable = true;
      cursor-autohide = 100;

      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec-codecs = "all";

      # forces showing subtitles while seeking through the video
      demuxer-mkv-subtitle-preroll = true;

      deband = true;
      deband-grain = 0;
      deband-range = 12;
      deband-threshold = 32;

      dither-depth = "auto";
      dither = "fruit";

      sub-auto = "fuzzy";
      # some settings fixing VOB/PGS subtitles (creating blur & changing yellow subs to gray)
      sub-gauss = "1.0";
      sub-gray = true;
      sub-use-margins = false;
      sub-font-size = 45;
      sub-scale-by-window = true;
      sub-scale-with-window = false;

      screenshot-directory = "~/Pictures/screenshots";

      slang = "en,eng,english";
      alang = "en,eng,english";

      write-filename-in-watch-later-config = true;
    };
    scripts = [
      pkgs.mpvScripts.dynamic-crop
      pkgs.mpvScripts.mpris
      pkgs.mpvScripts.seekTo
    ];
  };
}
