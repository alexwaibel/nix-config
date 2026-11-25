# Standalone home-manager on non-NixOS machines. NixOS hosts get these from the system instead.
{ lib, pkgs, ... }:
{
  imports = [ ../../shared/nix.nix ];

  nix.package = lib.mkDefault pkgs.nix;
  targets.genericLinux.enable = true;
}
