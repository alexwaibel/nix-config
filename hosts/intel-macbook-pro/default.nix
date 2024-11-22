{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../common/global
      ../common/optional/darwin
      ../common/users/alex
    ];

  networking.hostName = "Alexs-MacBook-Pro";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-darwin";
  
  # Set November 2024
  system.stateVersion = 5;
}
