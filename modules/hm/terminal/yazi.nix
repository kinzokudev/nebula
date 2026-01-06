{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    plugins = {
      inherit
        (pkgs.yaziPlugins)
        full-border
        git
        smart-enter
        smart-paste
        ;
    };
    initLua =
      /*
      lua
      */
      ''
        require("full-border"):setup({ type = ui.Border.ROUNDED })
        require("git"):setup()
      '';

    settings = {
      log = {
        enabled = true;
      };
      mgr = {
        ratio = [
          0
          1
          1
        ];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        linemode = "size";
        show_hidden = true;
      };
      opener = {
        # activate direnv before opening files
        # https://github.com/sxyazi/yazi/discussions/1083
        edit = [
          {
            run = "direnv exec . $EDITOR $1";
            block = true;
          }
        ];
      };
      # settings for plugins
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };

    theme = {
      mgr = {
        preview_hovered = {
          underline = false;
        };
        folder_offset = [
          1
          0
          1
          0
        ];
        preview_offset = [
          1
          1
          1
          1
        ];
      };

      mode = {
        normal_main = {
          bg = "cyan";
        };
        # normal_alt = {
        #   bg = "cyan";
        # };
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        # dropping to shell
        {
          on = "!";
          run =
            /*
            sh
            */
            ''
              shell "$SHELL" --block --confirm
            '';
          desc = "Open shell here";
        }
        # close input by a single Escape press
        {
          on = "<Esc>";
          run = "close";
          desc = "Cancel input";
        }
        # cd back to root of current git repo
        {
          on = [
            "g"
            "r"
          ];
          run =
            /*
            sh
            */
            ''
              shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
          desc = "Cd to root of current git repo";
        }
        # smart-enter
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        # smart-paste
        {
          on = "p";
          run = "plugin smart-paste";
          desc = "Paste into the hovered directory or CWD";
        }
      ];
    };
  };
}
