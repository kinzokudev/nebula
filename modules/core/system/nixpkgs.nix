{
  nixpkgs = {
    config = {
      # Allow unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "libsoup-2.74.3"
      ];
    };
  };
}
