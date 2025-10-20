{
  config,
  lib,
  ...
}: {
  options.custom = {
    gpu = {
      enable =
        lib.mkEnableOption "GPU"
        // {
          default = true;
        };
      vendor = lib.mkOption {
        type = lib.types.enum [
          "amd"
          "nvidia"
        ];
        default = "amd";
        description = "GPU vendor";
      };
      prime = {
        enable = lib.mkEnableOption "Nvidia Optimus PRIME";
        mode = lib.mkOption {
          type = lib.types.enum [
            "offload"
            "sync"
          ];
          default = "offload";
          description = "Which Optimus PRIME mode to use";
        };
        cpuVendor = lib.mkOption {
          type = lib.types.enum [
            "intel"
            "amd"
          ];
          default = "amd";
          description = "CPU vendor";
        };
        cpuBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "CPU Bus ID";
        };
        gpuBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "GPU Bus ID";
        };
      };
    };
  };
  config = lib.mkIf config.custom.gpu.enable {
    hardware = {
      # Enable graphics drivers
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      # Enable AMD GPU drivers
      amdgpu = lib.mkIf (config.custom.gpu.vendor == "amd") {
        opencl = {
          enable = true;
        };
        initrd = {
          enable = true;
        };
      };
      # Enable Nvidia GPU drivers
      nvidia = lib.mkIf (config.custom.gpu.vendor == "nvidia") {
        modesetting.enable = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        open = false;
        nvidiaSettings = true;
        prime = lib.mkIf config.custom.gpu.prime.enable {
          amdgpuBusId = lib.mkIf (
            config.custom.gpu.prime.cpuVendor == "amd"
          ) "${config.custom.gpu.prime.cpuBusId}";
          intelBusId = lib.mkIf (
            config.custom.gpu.prime.cpuVendor == "intel"
          ) "${config.custom.gpu.prime.cpuBusId}";
          nvidiaBusId = "${config.custom.gpu.prime.gpuBusId}";

          offload = lib.mkIf (config.custom.gpu.prime.mode == "offload") {
            enable = true;
            enableOffloadCmd = true;
          };

          sync = lib.mkIf (config.custom.gpu.prime.mode == "sync") {
            enable = true;
          };
        };
      };
    };

    services.xserver.videoDrivers =
      [
        "${lib.optionalString (config.custom.gpu.vendor == "nvidia") "nvidia"}" # Enable Nvidia GPU drivers if GPU vendor is Nvidia
        "${lib.optionalString (config.custom.gpu.vendor == "amd") "amdgpu"}" # Enable AMD GPU drivers if GPU vendor is AMD
      ]
      # Extra drivers if Nvidia Optimus PRIME is enabled
      ++ (lib.lists.optionals config.custom.gpu.prime.enable [
        "${lib.optionalString (config.custom.gpu.prime.mode == "offload") "modesetting"}" # Enable Modesetting driver if PRIME mode is set to Offload
        # Enable AMD GPU driver if PRIME mode is set to Offload and CPU vendor is AMD
        "${lib.optionalString (
          config.custom.gpu.prime.mode == "offload" && config.custom.gpu.prime.cpuVendor == "amd"
        ) "amdgpu"}"
      ]);
  };
}
