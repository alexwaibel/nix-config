# Secure Boot via lanzaboote, replacing plain systemd-boot. Keys are generated and enrolled on first boot,
# which needs the firmware in Setup Mode (see README).
{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./systemd-boot.nix
  ];

  # For debugging and troubleshooting Secure Boot (`sbctl status`, `sbctl verify`)
  environment.systemPackages = [ pkgs.sbctl ];

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys = {
      enable = true;
      autoReboot = true;
    };
  };
}
