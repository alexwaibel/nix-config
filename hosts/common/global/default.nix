# This file (and the global directory) holds config used on all hosts
{
  imports = [
    ./locale.nix
    ./nix.nix
  ];

  nixpkgs.config = import ../../../shared/nixpkgs-config.nix;
}
