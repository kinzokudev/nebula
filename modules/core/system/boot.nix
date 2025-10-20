{
  config,
  lib,
  ...
}: {
  options.custom = {
    bootloader = lib.mkOption {
      type = lib.types.enum [
        "grub"
        "systemd-boot"
      ];
      default = "systemd-boot";
      description = "Which bootloader to enable";
    };
  };
  config = {
    boot = {
      loader = {
        systemd-boot = lib.mkIf (config.custom.bootloader == "systemd-boot") {
          enable = true;
        };
        efi.canTouchEfiVariables = true;
      };

      kernel.sysctl = {
        # Increase open file limit
        "fs.file-max" = 100000000;
      };
    };
  };
}
