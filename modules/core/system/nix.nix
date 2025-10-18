{ inputs, ... }:
{
  # Configure nix
  nix = {
    settings = {
      # Enable nix command and flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixPath = [
      # Set nixpkgs path
      "nixpkgs=${inputs.nixpkgs}"
    ];
  };
}
