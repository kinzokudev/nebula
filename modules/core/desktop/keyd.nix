{
  config,
  lib,
  ...
}: {
  options.custom = {
    keyd = {
      enable = lib.mkEnableOption "keyd";
    };
  };
  config = lib.mkIf config.custom.keyd.enable {
    services.keyd = {
      # Enable and configure keyd
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(symbols, esc)";
            };
            symbols = {
              "1" = "kp1";
              "2" = "kp2";
              "3" = "kp3";
              "4" = "kp4";
              "5" = "kp5";
              "6" = "kp6";
              "7" = "kp7";
              "8" = "kp8";
              "9" = "kp9";
              "k" = "pageup";
              "j" = "pagedown";
              "d" = "delete";
            };
          };
        };
      };
    };
  };
}
