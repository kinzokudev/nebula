{
  inputs,
  outputs,
  userinfo,
  hostname,
  ...
}:
{
  imports = [
    ./core
    inputs.home-manager.nixosModules.home-manager
    # inputs.nix-flatpak.nixosModules.nix-flatpak
    # inputs.nur.modules.nixos.default
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit
        inputs
        outputs
        userinfo
        hostname
        ;
    };

    users = {
      ${userinfo.name} = import ./hm;
    };
    backupFileExtension = "backup";
  };
}
