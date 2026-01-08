# based on: https://github.com/iynaix/dotfiles/blob/17529889d2c758fd983b85d738c0dc3ece570587/modules/gui/wm/rofi.nix
{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      rofi = prev.rofi.override {
        plugins = with pkgs; [
          custom.rofi-themes
          rofi-calc
          rofi-emoji
          rofi-nerdy
        ];
      };
    })
  ];

  hm.xdg.configFile = {
    "rofi/catppuccin-macchiato.rasi".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/rofi/refs/heads/main/themes/catppuccin-macchiato.rasi";
      sha256 = "sha256:0y7rp6crrhir6j4sslx2786kr1pid8pbgg1mq6kyds3w76cjv6ac";
    };
    "rofi/catppuccin-default.rasi".text = let
      ctpDefault = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/rofi/refs/heads/main/catppuccin-default.rasi";
          sha256 = "sha256:1f3r6yarrykj8cxvi5hblzlr5n8zbncifnxps9xl5gl32w6ysq5z";
        }
      );
    in ''
      @import "catppuccin-macchiato"

      ${ctpDefault}
    '';
    "rofi/globals.rasi".text = ''
      @import "catppuccin-macchiato"

      configuration {
        modi: "drun,run,window,emoji";
        show-icons: true;
        display-drun: " ";
        display-run: " ";
        display-window: " ";
        display-emoji: " ";
        display-calc: " ";
        display-clipboard: "󰨸 ";
        drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        window-format: "{w} 󰧟 {c} 󰧟 {t}";
        // display-filebrowser: "󰉖";
        // display-clipboard: "󰅌";
        // display-dmenu: "󰍜";
        // dmenu-display-format: "󰍜";
        calc {
          hint-welcome: "";
        }
      }

      * {
        bg-color: @crust;
        bg-alt: @surface0;
        fg-color: @text;
        fg-subtle: @overlay0;
        fg-special: @lavender;
        bd-color: #6900ff;

        font: "JetBrainsMono Nerd Font 12";
      }
    '';
    "rofi/drun.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 800px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 0px 0px 8px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[DESKTOP RUN...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 2;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
    '';
    "rofi/run.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 800px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 4px 0px 8px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[SHELL RUN...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 2;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
    '';
    "rofi/emoji.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 800px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 4px 0px 6px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[EMOJI SEARCH...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 2;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
    '';
    "rofi/calc.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 400px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "message", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 4px 0px 6px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[CALCULATE...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 1;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
      message {
        enabled: true;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
      }
      textbox {
        padding: 5px 10px;
        border-radius: 4px;
        border: 0px 0px 1px 0px solid;
        border-color: @surface2;
        background-color: @bg-color;
        text-color: @fg-color;
        vertical-align: 0.5;
        horizontal-align: 0.0;
        highlight: none;
        placeholder-color: @fg-subtle;
        placeholder: "[OUTPUT...]";
      }
    '';
    "rofi/window.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 800px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 0px 0px 8px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[WINDOW SEARCH...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 2;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: false;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
    '';
    "rofi/clipboard.rasi".text = ''
      @import "globals"

      window {
        enabled: true;
        width: 800px;
        border-radius: 8px;
        border: 2px solid;
        border-color: @bd-color;
        padding: 0px;
        location: center;
        anchor: center;
        fullscreen: false;
        x-offset: 0px;
        y-offset: 0px;
        margin: 0px;
        cursor: "default";
        background-color: @bg-color;
      }
      mainbox {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 10px 8px;
        background-color: transparent;
        children: ["inputbar", "listview" ];
      }
      inputbar {
        enabled: true;
        spacing: 0px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        children: ["prompt",  "entry"];
      }

      prompt {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        font: "JetBrainsMono Nerd Font 24";
        margin: 0px 0px 0px 8px;
        padding: 0px;
      }
      entry {
        enabled: true;
        background-color: inherit;
        text-color: inherit;
        cursor: text;
        placeholder: "[CLIPBOARD HISTORY...]";
        placeholder-color: @fg-subtle;
        margin: 0px;
        padding: 10px 0px;
      }


      listview {
        enabled: true;
        columns: 1;
        lines: 10;
        cycle: true;
        dynamic: true;
        scrollbar: true;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;

        spacing: 5px;
        margin: 0px;
        padding: 0px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: "default";
      }
      scrollbar {
        handle-width: 4px;
        handle-color: @fg-special;
        border-radius: 4px;
        background-color: @bg-alt;
      }
      element {
        enabled: true;
        spacing: 10px;
        margin: 0px;
        padding: 5px 10px;
        border-radius: 6px;
        background-color: transparent;
        text-color: @fg-color;
        cursor: pointer;
      }
      element normal.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element normal.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element normal.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element selected.normal {
        background-color: @bg-alt;
        text-color: @fg-color;
      }
      element selected.urgent {
        background-color: @bg-alt;
        text-color: @red;
      }
      element selected.active {
        background-color: @bg-alt;
        text-color: @green;
      }
      element alternate.normal {
        background-color: @bg-color;
        text-color: @fg-color;
      }
      element alternate.urgent {
        background-color: @bg-color;
        text-color: @red;
      }
      element alternate.active {
        background-color: @bg-color;
        text-color: @green;
      }
      element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 20px;
        cursor: inherit;
      }
      element-text {
        background-color: transparent;
        text-color: inherit;
        highlight: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
      }
    '';
  };

  environment.systemPackages = [
    pkgs.rofi
  ];
}
