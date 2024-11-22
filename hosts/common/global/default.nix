# This file (and the global directory) holds config used on all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./fish.nix
      ./nix.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}