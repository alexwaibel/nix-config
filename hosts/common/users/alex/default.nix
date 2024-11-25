{
  pkgs,
  config,
  lib,
  specialArgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.alex = {
    ${if !pkgs.stdenv.isDarwin then "isNormalUser" else null} = true;
    description = "Alex";
    shell = pkgs.fish;
    ${if !pkgs.stdenv.isDarwin then "extraGroups" else null} = ifTheyExist [
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
