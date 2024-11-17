# This file should be included when using hm standalone
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}