{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "overload(nav, esc)";
          rightshift = "overload(nums, rightshift)";
        };
        nav = {
          "h" = "left";
          "j" = "down";
          "k" = "up";
          "l" = "right";

          "H" = "home";
          "J" = "pagedown";
          "K" = "pageup";
          "L" = "end";

          "d" = "delete";
        };
        nums = {
          "1" = "6";
          "2" = "7";
          "3" = "8";
          "4" = "9";
          "5" = "0";
        };
      };
    };
  };
}
