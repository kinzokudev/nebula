{config, ...}: let
in {
  #|===|#
  "Mod+Return".spawn = "kitty";
  # "Mod+P".spawn = ["rofi" "-show" "drun" "-theme" "${config.xdg.configHome}/rofi/drun.rasi"];
  "Mod+P".spawn = ["dms" "ipc" "spotlight" "toggle"];
  # "Mod+Shift+P".spawn = ["rofi" "-show" "run" "-theme" "${config.xdg.configHome}/rofi/run.rasi"];
  "Mod+E".spawn = ["rofi" "-show" "emoji" "-theme" "${config.xdg.configHome}/rofi/emoji.rasi"];
  "Mod+Q".spawn = ["rofi" "-show" "calc" "-theme" "${config.xdg.configHome}/rofi/calc.rasi"];
  "Mod+Shift+W".spawn = ["rofi" "-show" "window" "-theme" "${config.xdg.configHome}/rofi/window.rasi"];
  # "Mod+V".spawn = ["rofi-clipboard-history"];
  "Mod+V".spawn = ["dms" "ipc" "clipboard" "toggle"];
  "Mod+Shift+Z".spawn = ["kitty" "pulsemixer"];
  # "Mod+N".spawn = ["dunstctl" "history-pop"];
  "Mod+N".spawn = ["dms" "ipc" "notifications" "toggle"];
  "Mod+Shift+N".spawn = ["dms" "ipc" "notifications" "clearAll"];
  "Mod+Shift+X".spawn = ["dms" "ipc" "settings" "toggle"];
  "Mod+X".spawn = ["dms" "ipc" "notepad" "toggle"];
  "Mod+Alt+L".spawn = ["dms" "ipc" "lock" "lock"];
  "Mod+Shift+P".spawn = ["dms" "ipc" "powermenu" "toggle"];
  "Mod+M".spawn = ["dms" "ipc" "processlist" "toggle"];
  #|===|#

  #|===|#
  "Mod+F".fullscreen-window = [];
  "Mod+Z".maximize-column = [];
  "Mod+R".switch-preset-column-width = [];
  "Mod+Shift+R".switch-preset-window-height = [];
  "Mod+Ctrl+R".reset-window-height = [];
  "Mod+C".center-column = [];
  "Mod+Shift+Q".toggle-overview = [];
  "Mod+T".toggle-window-floating = [];
  "Mod+Tab".switch-focus-between-floating-and-tiling = [];
  "Mod+W".toggle-column-tabbed-display = [];
  "Mod+Shift+C".close-window = [];
  #
  "Mod+BracketLeft".set-column-width = "-10%";
  "Mod+BracketRight".set-column-width = "+10%";
  "Mod+Shift+BracketLeft".set-window-height = "-10%";
  "Mod+Shift+BracketRight".set-window-height = "+10%";
  #
  "Mod+Shift+S".screenshot = [];
  "Shift+Print".screenshot-window = [];
  "Ctrl+Print".screenshot-screen = [];
  #
  "Mod+Shift+Escape".quit = [];
  "Mod+Escape".toggle-keyboard-shortcuts-inhibit = [];
  #|===|#

  #|===|#
  "Mod+H".focus-column-or-monitor-left = [];
  "Mod+J".focus-window-or-workspace-down = [];
  "Mod+K".focus-window-or-workspace-up = [];
  "Mod+L".focus-column-or-monitor-right = [];
  #
  "Mod+Shift+H".move-column-left-or-to-monitor-left = [];
  "Mod+Shift+J".move-column-to-workspace-down = [];
  "Mod+Shift+K".move-column-to-workspace-up = [];
  "Mod+Shift+L".move-column-right-or-to-monitor-right = [];
  #
  "Mod+Ctrl+H".focus-monitor-left = [];
  "Mod+Ctrl+J".focus-monitor-down = [];
  "Mod+Ctrl+K".focus-monitor-up = [];
  "Mod+Ctrl+L".focus-monitor-right = [];
  #
  "Mod+Shift+Ctrl+H".move-window-to-monitor-left = [];
  "Mod+Shift+Ctrl+J".move-window-to-monitor-down = [];
  "Mod+Shift+Ctrl+K".move-window-to-monitor-up = [];
  "Mod+Shift+Ctrl+L".move-window-to-monitor-right = [];
  #
  "Mod+A".focus-column-left-or-last = [];
  "Mod+S".focus-column-right-or-first = [];
  #
  "Mod+Comma".consume-or-expel-window-left = [];
  "Mod+Period".consume-or-expel-window-right = [];
  #|===|#

  #|===|#
  # "XF86AudioRaiseVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05+"];
  # "XF86AudioLowerVolume".spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05-"];
  # "XF86AudioMute".spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"];
  "XF86AudioRaiseVolume".spawn = ["dms" "ipc" "audio" "increment" "3"];
  "XF86AudioLowerVolume".spawn = ["dms" "ipc" "audio" "decrement" "3"];
  "XF86AudioMute".spawn = ["dms" "ipc" "audio" "mute"];
  "XF86AudioMicMute".spawn = ["dms" "ipc" "audio" "micmute"];
  "Mod+Shift+M".spawn = ["dms" "ipc" "audio" "micmute"];
  #
  "XF86MonBrightnessUp".spawn = ["dms" "ipc" "brightness" "increment" "5" ""];
  "XF86MonBrightnessDown".spawn = ["dms" "ipc" "brightness" "decrement" "5" ""];
  "Mod+Alt+N".spawn = ["dms" "ipc" "night" "toggle"];
  #|===|#

  # "MouseForward".focus-workspace-up = [];
  # "MouseBack".focus-workspace-down = [];

  "Mod+WheelScrollDown" = {
    _props = {
      cooldown-ms = 150;
    };
    focus-window-or-workspace-down = [];
  };
  "Mod+WheelScrollUp" = {
    _props = {
      cooldown-ms = 150;
    };
    focus-window-or-workspace-up = [];
  };

  # "Mod+H".focus-column-left-or-last = [];
  # "Mod+L".focus-column-right-or-first = [];
  # "Mod+Shift+H".move-column-left = [];
  # "Mod+Shift+L".move-column-right = [];
  # "Alt+H".focus-monitor-left = [];
  # "Alt+L".focus-monitor-right = [];
  # "Alt+Shift+H".move-column-to-monitor-left = [];
  # "Alt+Shift+L".move-column-to-monitor-right = [];
}
