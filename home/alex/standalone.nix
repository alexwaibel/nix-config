# Standalone home-manager on non-NixOS machines. NixOS hosts get these from the system instead.
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ (inputs.self + "/shared/nix.nix") ];

  nix.package = lib.mkDefault pkgs.nix;
  targets.genericLinux.enable = true;
}
