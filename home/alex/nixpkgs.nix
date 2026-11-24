# This file should be included when using hm standalone
{ lib, pkgs, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # NixOS hosts collect garbage system-wide; standalone machines need it per user
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2w";
    };
  };
}
