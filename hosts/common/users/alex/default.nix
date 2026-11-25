{
  inputs,
  outputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  # Registers fish as a login shell (required by `shell` below); fish itself is configured in home-manager
  programs.fish.enable = true;

  users.users.alex = {
    isNormalUser = true;
    description = "Alex";
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "docker"
      "networkmanager"
      "systemd-journal"
      "wheel"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (
      builtins.readFile ../../../../home/alex/ssh.pub
    );
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.alex = import ../../../../home/alex/${config.networking.hostName}.nix;
  };
}
