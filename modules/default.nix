{
  inputs,
  outputs,
  userinfo,
  hostname,
  ...
}: {
  imports = [
    ./nixos
    inputs.home-manager.nixosModules.home-manager
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
