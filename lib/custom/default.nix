{
  lib,
  ...
}:
{
  getSSHPubkeyFile =
    username: sha256:
    (builtins.fetchurl {
      url = "https://github.com/${username}.keys";
      inherit sha256;
    });
  getSSHPubkeys =
    username: sha256:
    builtins.readFile (
      builtins.fetchurl {
        url = "https://github.com/${username}.keys";
        inherit sha256;
      }
    );
  getSSHPubkeyList =
    username: sha256:
    lib.splitString "\n" (
      builtins.readFile (
        builtins.fetchurl {
          url = "https://github.com/${username}.keys";
          inherit sha256;
        }
      )
    );
}
