{
  pkgs,
  config,
  lib,
  specialArgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  darwin = specialArgs.darwin or false;
in {
  users.users.alex = {
    ${if !darwin then "isNormalUser" else null} = true;
    description = "Alex";
    shell = pkgs.fish;
    ${if !darwin then "extraGroups" else null} = ifTheyExist [
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
