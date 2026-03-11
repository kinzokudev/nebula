{self, ...}: {
  flake.nixosModules.host-nova = {
    imports = with self.nixosModules; [
      server
    ];
    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "192.168.40.20"
    ];
  };
}
