{
  pkgs,
  config,
  lib,
  darwin ? false,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.alex = {
    isNormalUser = lib.mkIf !darwin true;
    description = "Alex";
    shell = pkgs.fish;
    extraGroups = lib.mkIf !darwin ifTheyExist [
      "docker"
      "networkmanager"
      "systemd-journal"
      "wheel"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/alex/ssh.pub);
    packages = [pkgs.home-manager];
  };

  home-manager.users.alex = import ../../../../home/alex/${config.networking.hostName}.nix;
}