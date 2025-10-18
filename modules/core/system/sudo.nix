{
  config,
  lib,
  userinfo,
  ...
}:
{
  options.custom = {
    sudo = {
      passwordless = lib.mkEnableOption "passwordless sudo";
    };
  };
  config = {
    security.sudo = {
      extraRules = [
        {
          users = [ "${userinfo.name}" ];
          commands = [
            {
              command = "ALL";
              options = [
                "SETENV"
                "${lib.optionalString config.custom.sudo.passwordless "NOPASSWD"}"
              ];
            }
          ];
        }
      ];
    };
  };
}
