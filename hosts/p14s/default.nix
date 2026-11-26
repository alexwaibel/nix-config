# ThinkPad P14s Gen 3 (Intel)
{ inputs, lib, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen3
    ./disk-config.nix
    ../common/global
    ../common/optional/cosmic.nix
    ../common/optional/pipewire.nix
    ../common/optional/secure-boot.nix
    ../common/users/alex
  ];

  networking = {
    hostName = "p14s";
    networkmanager.enable = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Written by `nixos-anywhere --generate-hardware-config nixos-facter` during install
  hardware.facter.reportPath = lib.mkIf (builtins.pathExists ./facter.json) ./facter.json;

  boot.loader.efi.canTouchEfiVariables = true;
  hardware.bluetooth.enable = true;
  services.fwupd.enable = true;
  # Run downloaded binaries (mise tools, self-updating Copilot CLI)
  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
