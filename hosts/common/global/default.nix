# This file (and the global directory) holds config used on all hosts
{ inputs, ... }:
{
  imports = [
    ./locale.nix
    ./nix.nix
  ];

  nixpkgs.config = import (inputs.self + "/shared/nixpkgs-config.nix");
}
