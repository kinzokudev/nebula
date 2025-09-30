{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-a";
    sensibleOnTop = true;
    extraConfig = ''
      set -g mouse on
      set-option -g allow-rename off
      set -g escape-time 10

      unbind %
      bind | split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      unbind n
      bind-key n command-prompt -I "rename-window "

      unbind N
      bind-key N command-prompt -I "rename-session "

      unbind '&'
      bind C-x kill-window

      bind-key x kill-pane

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind -n M-H previous-window
      bind -n M-L next-window
      bind -n S-Left previous-window
      bind -n S-Right next-window

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy -n'

      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # clock mode
      setw -g clock-mode-colour cyan

      # copy mode
      setw -g mode-style 'fg=black bg=blue bold'

      # panes
      set -g pane-border-style 'fg=blue'
      set -g pane-active-border-style 'fg=cyan'

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=blue'

      set -g status-left-style 'fg=brightcyan'
      set -g status-left '[#S] '
      set -g status-left-length 10

      set -g status-right-style 'fg=black bg=cyan'
      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50

      setw -g window-status-current-style 'fg=black bg=blue'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=blue bg=black'
      setw -g window-status-format ' #I #[fg=white]#W #[fg=cyan]#F '

      setw -g window-status-bell-style 'fg=cyan bg=blue bold'

      # messages
      set -g message-style 'fg=cyan bg=blue bold'

      # window and pane renumbering
      set -g renumber-windows on

      set-option -g history-limit 5000

      set -gq allow-passthrough on
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      dracula
      yank
      tmux-fzf
    ];
  };
}
